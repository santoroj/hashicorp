import boto3

# Create a Boto3 client for EC2
ec2_client = boto3.client('ec2')

# Retrieve all regions
regions = [region['RegionName'] for region in ec2_client.describe_regions()['Regions']]

print(f"List ALL Regions : {regions}")
print("\n\n")

# List all EC2 instances in each region
for region in regions:
    print(f"Instances in region: {region}")
    ec2_client = boto3.client('ec2', region_name=region)
    response = ec2_client.describe_instances()

    for reservation in response['Reservations']:
        print(f"DEBUG: reservation : {reservation}")
        for instance in reservation['Instances']:
            instance_id = instance['InstanceId']
            instance_state = instance['State']['Name']
            instance_type = instance['InstanceType']
            print(f"Instance ID: {instance_id}, State: {instance_state}, Type: {instance_type}")

    print()
