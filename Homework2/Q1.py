import numpy as np
from scipy.ndimage import median_filter

# Given 4x4 grayscale image
original_image = np.array([[1, 2, 1, 3],
                           [1, 2, 2, 4],
                           [1, 0, 2, 5],
                           [0, 2, 3, 6]])

# Zero-padding the image
padded_image = np.pad(original_image, ((1, 1), (1, 1)), mode='constant', constant_values=(0))

# Print the padded image
print("Padded Image:")
for row in padded_image:
    print(*row)

print("\n")

# Apply median filter
filtered_image = median_filter(padded_image, size=3)

# Remove the zero-padded border
result = filtered_image[1:-1, 1:-1]

# Print the filtered image
print("Filtered Image:")
for row in result:
    print(*row)

# Given 4x4 grayscale image
original_image = np.array([[1, 2, 1, 3],
                           [1, 2, 2, 4],
                           [1, 0, 2, 5],
                           [0, 2, 3, 6]])

# Replicate padding (nearest neighborhood)
padded_image = np.pad(original_image, ((1, 1), (1, 1)), mode='edge')

# Print the padded image
print("Padded Image:")
for row in padded_image:
    print(*row)
print("\n")

# Initialize an empty array for the filtered image
filtered_image = np.zeros_like(original_image)

# Apply arithmetic mean filter
print("Mean Filter Value:")
for i in range(1, original_image.shape[0] + 1):
    for j in range(1, original_image.shape[1] + 1):
        window = padded_image[i - 1:i + 2, j - 1:j + 2]
        average_value = np.mean(window)
        print(average_value)
        filtered_image[i - 1, j - 1] = round(average_value)
print("\n")

# Print the filtered image
print("Filtered Image:")
for row in filtered_image:
    print(*row)

# Given 4x4 grayscale image
original_image = np.array([[1, 2, 1, 3],
                           [1, 2, 2, 4],
                           [1, 0, 2, 5],
                           [0, 2, 3, 6]])

# Zero-padding the image
padded_image = np.pad(original_image, ((1, 1), (1, 1)), mode='constant', constant_values=(0))

# Print the padded image
print("Padded Image:")
for row in padded_image:
    print(*row)
print("\n")

# Initialize the Laplacian filter
laplacian_filter = np.array([[0, 1, 0],
                             [1, -4, 1],
                             [0, 1, 0]])

# Initialize an empty array for the filtered image
filtered_image = np.zeros_like(original_image)

# Apply Laplacian filter
print("Laplacian Filter Value:")
for i in range(1, original_image.shape[0] + 1):
    for j in range(1, original_image.shape[1] + 1):
        window = padded_image[i - 1:i + 2, j - 1:j + 2]
        laplacian_value = np.sum(window * laplacian_filter)
        print(laplacian_value)
        filtered_image[i - 1, j - 1] = round(laplacian_value)
print("\n")


# Print the filtered image
print("Filtered Image:")
for row in filtered_image:
    print(*row)

