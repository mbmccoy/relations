import torch

def test_gpus():
    if torch.cuda.is_available():
        print(f"Number of GPUs available: {torch.cuda.device_count()}")
        for i in range(torch.cuda.device_count()):
            gpu_name = torch.cuda.get_device_name(i)
            print(f"GPU {i}: {gpu_name}")
            # Allocate a tensor on each GPU to test if it's functioning properly
            try:
                x = torch.randn((1000, 1000), device=f"cuda:{i}")
                print(f"Successfully created tensor on GPU {i}")
            except Exception as e:
                print(f"Failed to create tensor on GPU {i}: {e}")
    else:
        print("No GPUs are available.")

if __name__ == "__main__":
    test_gpus()
