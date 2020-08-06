# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

host_project_id        = attribute('host_project_id')
service_project_id     = attribute('service_project_id')
service_project_number = attribute('service_project_number')
gke_subnet_name        = attribute('gke_subnet_name')
gke_subnet_region      = attribute('gke_subnet_region')

control 'svpc-gke-access' do
  title "GKE shared VPC access"

  describe command("gcloud compute shared-vpc get-host-project #{service_project_id} --format='get(name)'") do
    its('exit_status') { should eq 0 }
    its('stderr') { should eq '' }
    its('stdout.strip') { should eq host_project_id }
  end

  describe command("gcloud projects get-iam-policy #{host_project_id} --format=json") do
    its('exit_status') { should eq 0 }
    its('stderr') { should eq '' }

    let(:bindings) do
      if subject.exit_status == 0
        JSON.parse(subject.stdout, symbolize_names: true)[:bindings]
      else
        []
      end
    end

    describe "roles/compute.networkUser" do
      it "does not include the GKE service account in the roles/compute.networkUser IAM binding" do
        expect(bindings).not_to include(
          members: including(
            "serviceAccount:service-#{service_project_number}@container-engine-robot.iam.gserviceaccount.com"
          ),
          role: "roles/compute.networkUser",
        )
      end
    end

    it "includes the GKE service account in the roles/container.hostServiceAgentUser IAM binding" do
      expect(bindings).to include(
        members: including("serviceAccount:service-#{service_project_number}@container-engine-robot.iam.gserviceaccount.com"),
        role: "roles/container.hostServiceAgentUser",
      )
    end
  end

  describe command("gcloud beta compute networks subnets get-iam-policy #{gke_subnet_name} --region #{gke_subnet_region} --project #{host_project_id} --format=json") do
    its('exit_status') { should eq 0 }
    its('stderr') { should eq '' }

    let(:bindings) do
      if subject.exit_status == 0
        JSON.parse(subject.stdout, symbolize_names: true)[:bindings]
      else
        []
      end
    end

    describe "roles/compute.networkUser" do
      it "includes the project service account in the roles/compute.networkUser IAM binding" do
        expect(bindings).to include(
          members: including("serviceAccount:service-#{service_project_number}@container-engine-robot.iam.gserviceaccount.com"),
          role: "roles/compute.networkUser",
        )
        expect(bindings).to include(
          members: including("serviceAccount:#{service_project_number}@cloudservices.gserviceaccount.com"),
          role: "roles/compute.networkUser",
        )
      end
    end
  end
end
