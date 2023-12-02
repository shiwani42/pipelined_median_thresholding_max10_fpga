# EE214
Self project of course,
# Implementation of Pipelined Median and Binary Thresholding Filtering on Max-10 FPGA
Abstract :
In this project Pipelined Median and Binary Thresholding Filtering is used to detect underwater gas pipelines using Xen-10 board. The uni-color gas pipeline detection in a 128x128
pixels Red-Green-Blue(RGB) Image is proposed in this project. The 128x128 pixel RGB Image is converted into the binary format and stored inside Block RAMs (BRAM). When data is
stored inside the BRAM, then 3x3 kernel is transferred in each clock cycle to the Pipelined
Medain Filter using Intermediate Line Buffers between BRAM and the Pipelined Median
Filter. After Median Filter operation, data is stored in BRAM and Binary Thresholding Filtering is done for gas pipeline detection. The data is extracted from BRAM after Binary
Thresholding Filtering and compared with the MATLAB software simulated results.
# Work done:
1. Performed Median and Binary Thresholding Filtering on a 128x128 RGB Test image on MATLAB. Extract Raw Image data in binary format of a Test image using MATLAB.
2. Implementation of Pipelined Median Filter and Binary Thresholding. Access
3. On-chip Dual Port RAM using Altera-IP and store the raw data in the RAM
4. Implementation of 4-Line Buffers for achieving Hardware Acceleration.
5. Design Datapath Controller for Controlling the data Path
