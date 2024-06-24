import torch

checkpoint_path = "./pretrained_models/v1-5-pruned.ckpt"

# Load the checkpoint
checkpoint = torch.load(checkpoint_path, map_location="cpu")

# Get the keys from the state_dict
state_dict_keys = checkpoint['state_dict'].keys()

# Print the keys
for key in state_dict_keys:
    print(key)

# log the keys in txt file
with open('state_dict_keys.txt', 'w') as f:
    for key in state_dict_keys:
        f.write("%s\n" % key)