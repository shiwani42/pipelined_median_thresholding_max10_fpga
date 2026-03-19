# Pipelined Median and Binary Thresholding Filtering

## Project Overview

Implementation of Pipelined Median and Binary Thresholding Filtering on MAX-10 FPGA for underwater gas pipeline detection using the Xen-10 board.

## Abstract

This project implements uni-color gas pipeline detection in a 128x128 pixels Red-Green-Blue (RGB) Image. The 128x128 pixel RGB Image is converted into binary format and stored inside Block RAMs (BRAM). When data is stored inside the BRAM, a 3x3 kernel is transferred in each clock cycle to the Pipelined Median Filter using Intermediate Line Buffers between BRAM and the Pipelined Median Filter. After Median Filter operation, data is stored in BRAM and Binary Thresholding Filtering is done for gas pipeline detection. The data is extracted from BRAM after Binary Thresholding Filtering and compared with the MATLAB software simulated results.

## Hardware Requirements

- **FPGA Board**: MAX-10 (Altera)
- **Target Device**: Xen-10 Board
- **Image Size**: 128x128 pixels (grayscale, 8-bit per pixel)

## Implementation Details

### Architecture

The design uses a fully pipelined architecture with the following data flow:

```
BRAM (Dual-Port) → DEMUX → 4 Line Buffers → MUXes → Encoder → Median Filter → Binary Thresholding → BRAM
                        ↑___________________________________|
```

### Components

| Component | File | Description |
|-----------|------|-------------|
| **BRAM** | `bram.vhd` | Dual-port RAM using Altera IP (altsyncram), 65536 words x 8-bit, pre-initialized with image data via BRAM.mif |
| **DEMUX** | `DEMUX.vhdl` | 1-to-4 demultiplexer distributing pixel data to 4 line buffers |
| **Line Buffers** | `buffer_register.vhd` | 4 parallel line buffers, each storing 128 pixels (128 registers deep) |
| **MUXes** | `MUX.vhd` | 4 2-to-1 multiplexers for selecting current/latched pixel data |
| **Encoder** | `Encoder.vhdl` | Assembles 3x3 kernel from 4 line buffers (71-bit output for 9 pixels) |
| **Median Filter** | `median_filter.vhd` | 3x3 median filter implementing bubble sort algorithm |
| **Binary Thresholding** | `binary_thresholding.vhd` | Compares pixel value against threshold (140 decimal = 0x8C) |
| **Up Counter** | `up_counter.vhdl` | 16-bit counter generating sequential addresses |
| **Register Block** | `register_block.vhd` | 8-bit register using D flip-flops (ddff) |
| **Toplevel** | `Toplevel.vhdl` | Top-level integration of all components |

### Median Filter Algorithm

The median filter uses a bubble sort approach:
- Takes 9 pixels (3x3 kernel) as input
- Sorts all 9 values in ascending order
- Outputs the middle value (index 4) as the median

### Binary Thresholding

- Threshold value: 140 (0x8C in hex)
- If pixel > threshold: output = 255 (0xFF)
- If pixel <= threshold: output = 0

### Data Path Widths

- Pixel data: 8 bits
- BRAM address: 16 bits (65536 locations)
- Line buffer output: 24 bits (3 pixels)
- Encoder output: 72 bits (9 pixels)

### Pipeline Stages

1. **Stage 1**: BRAM read → DEMUX
2. **Stage 2**: Line buffers latch data
3. **Stage 3**: MUX selects current vs previous row
4. **Stage 4**: Encoder assembles 3x3 kernel
5. **Stage 5**: Median filter computes median
6. **Stage 6**: Binary thresholding produces final output
7. **Stage 7**: Write back to BRAM

## Work Done

1. **MATLAB Verification**: Performed Median and Binary Thresholding Filtering on a 128x128 RGB test image in MATLAB. Extracted raw image data in binary format.
2. **VHDL Implementation**: Implemented Pipelined Median Filter and Binary Thresholding in VHDL.
3. **BRAM Integration**: On-chip Dual Port RAM using Altera-IP (altsyncram) with initialization via BRAM.mif file.
4. **Line Buffers**: Implemented 4-line buffers for achieving hardware acceleration and proper 3x3 kernel formation.
5. **Datapath Controller**: Designed datapath controller for controlling the data path.

## Files Description

| File | Purpose |
|------|----------|
| `Toplevel.vhdl` | Top-level module integrating all components |
| `median_filter.vhd` | 3x3 median filter implementation |
| `binary_thresholding.vhd` | Binary thresholding filter |
| `bram.vhd` | Dual-port BRAM IP instantiation |
| `buffer_register.vhd` | Line buffer with 128 registers |
| `register_block.vhd` | Basic 8-bit register |
| `Encoder.vhdl` | 3x3 kernel encoder |
| `DEMUX.vhdl` | 1-to-4 demultiplexer |
| `MUX.vhd` | 2-to-1 multiplexers (4 instances) |
| `up_counter.vhdl` | 16-bit address counter |
| `Testbench.vhdl` | Simulation testbench |
| `BRAM.mif` | Memory initialization file for BRAM |
| `text_image_1.csv` | Input image data |
| `binary_image2.csv` | Output binary image data |

## Simulation

The design has been verified using ModelSim-Altera. The testbench (`Testbench.vhdl`) instantiates the top-level module and provides clock signals for simulation.

## Notes

- The design uses synchronous logic with clock enable
- Reset signal initializes all registers
- Image data is pre-loaded into BRAM via the .mif file
- The pipeline processes one pixel per clock cycle after initial latency
