import boto3

def get_available_az_count(region_name):
    ec2_client = boto3.client('ec2', region_name=region_name)
    response = ec2_client.describe_availability_zones()
    az_count = len(response['AvailabilityZones'])
    return az_count

if __name__ == "__main__":
    region_name = 'eu-west-2'  # Replace 'your_region_name' with the AWS region name you want to check
    available_az_count = get_available_az_count(region_name)
    print(f"Number of Availability Zones in {region_name} is {available_az_count} ")


