////////////////////////////////////////////////////////////////////////////////
//                                            __ _      _     _               //
//                                           / _(_)    | |   | |              //
//                __ _ _   _  ___  ___ _ __ | |_ _  ___| | __| |              //
//               / _` | | | |/ _ \/ _ \ '_ \|  _| |/ _ \ |/ _` |              //
//              | (_| | |_| |  __/  __/ | | | | | |  __/ | (_| |              //
//               \__, |\__,_|\___|\___|_| |_|_| |_|\___|_|\__,_|              //
//                  | |                                                       //
//                  |_|                                                       //
//                                                                            //
//                                                                            //
//              PU RISCV / OR1K / MSP430                                      //
//              Universal Verification Methodology                            //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

/* Copyright (c) 2020-2021 by the author(s)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * =============================================================================
 * Author(s):
 *   Paco Reina Campo <pacoreinacampo@queenfield.tech>
 */

interface riscv_interface;

  logic clk;
  logic rst;
  logic rst_cpu;
  logic rst_sys;

  dii_flit [1:0] debug_ring_in;
  dii_flit [1:0] debug_ring_out;

  logic [1:0] debug_ring_in_ready;
  logic [1:0] debug_ring_out_ready;

  logic            ahb3_ext_hsel_i;
  logic [PLEN-1:0] ahb3_ext_haddr_i;
  logic [XLEN-1:0] ahb3_ext_hwdata_i;
  logic            ahb3_ext_hwrite_i;
  logic [     2:0] ahb3_ext_hsize_i;
  logic [     2:0] ahb3_ext_hburst_i;
  logic [     3:0] ahb3_ext_hprot_i;
  logic [     1:0] ahb3_ext_htrans_i;
  logic            ahb3_ext_hmastlock_i;

  logic [XLEN-1:0] ahb3_ext_hrdata_o;
  logic            ahb3_ext_hready_o;
  logic            ahb3_ext_hresp_o;

  // Flits from NoC->tiles
  logic [CHANNELS-1:0][FLIT_WIDTH-1:0] link_in_flit;
  logic [CHANNELS-1:0]                 link_in_last;
  logic [CHANNELS-1:0]                 link_in_valid;
  logic [CHANNELS-1:0]                 link_in_ready;

  // Flits from tiles->NoC
  logic [CHANNELS-1:0][FLIT_WIDTH-1:0] link_out_flit;
  logic [CHANNELS-1:0]                 link_out_last;
  logic [CHANNELS-1:0]                 link_out_valid;
  logic [CHANNELS-1:0]                 link_out_ready;
  
  clocking master_cb @(posedge clk);
    output clk;
    output rst;
    output rst_cpu;
    output rst_sys;

    output debug_ring_in;
    input  debug_ring_out;

    input  debug_ring_in_ready;
    output debug_ring_out_ready;

    input  ahb3_ext_hsel_i;
    input  ahb3_ext_haddr_i;
    input  ahb3_ext_hwdata_i;
    input  ahb3_ext_hwrite_i;
    input  ahb3_ext_hsize_i;
    input  ahb3_ext_hburst_i;
    input  ahb3_ext_hprot_i;
    input  ahb3_ext_htrans_i;
    input  ahb3_ext_hmastlock_i;

    output ahb3_ext_hrdata_o;
    output ahb3_ext_hready_o;
    output ahb3_ext_hresp_o;

    // Flits from NoC->tiles
    output link_in_flit;
    output link_in_last;
    output link_in_valid;
    input  link_in_ready;

    // Flits from tiles->NoC
    input  link_out_flit;
    input  link_out_last;
    input  link_out_valid;
    output link_out_ready;
  endclocking : master_cb

  clocking slave_cb @(posedge clk);
    input  clk;
    input  rst;
    input  rst_cpu;
    input  rst_sys;

    input  debug_ring_in;
    output debug_ring_out;

    output debug_ring_in_ready;
    input  debug_ring_out_ready;

    output ahb3_ext_hsel_i;
    output ahb3_ext_haddr_i;
    output ahb3_ext_hwdata_i;
    output ahb3_ext_hwrite_i;
    output ahb3_ext_hsize_i;
    output ahb3_ext_hburst_i;
    output ahb3_ext_hprot_i;
    output ahb3_ext_htrans_i;
    output ahb3_ext_hmastlock_i;

    input  ahb3_ext_hrdata_o;
    input  ahb3_ext_hready_o;
    input  ahb3_ext_hresp_o;

    // Flits from NoC->tiles
    input  link_in_flit;
    input  link_in_last;
    input  link_in_valid;
    output link_in_ready;

    // Flits from tiles->NoC
    output link_out_flit;
    output link_out_last;
    output link_out_valid;
    input  link_out_ready;
  endclocking : slave_cb
  
  clocking monitor_cb @(posedge clk);
    input clk;
    input rst;
    input rst_cpu;
    input rst_sys;

    input debug_ring_in;
    input debug_ring_out;

    input debug_ring_in_ready;
    input debug_ring_out_ready;

    input ahb3_ext_hsel_i;
    input ahb3_ext_haddr_i;
    input ahb3_ext_hwdata_i;
    input ahb3_ext_hwrite_i;
    input ahb3_ext_hsize_i;
    input ahb3_ext_hburst_i;
    input ahb3_ext_hprot_i;
    input ahb3_ext_htrans_i;
    input ahb3_ext_hmastlock_i;

    input ahb3_ext_hrdata_o;
    input ahb3_ext_hready_o;
    input ahb3_ext_hresp_o;

    // Flits from NoC->tiles
    input link_in_flit;
    input link_in_last;
    input link_in_valid;
    input link_in_ready;

    // Flits from tiles->NoC
    input link_out_flit;
    input link_out_last;
    input link_out_valid;
    input link_out_ready;
  endclocking : monitor_cb

  modport master(clocking master_cb);
  modport slave(clocking slave_cb);
  modport passive(clocking monitor_cb);
endinterface
