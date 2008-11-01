Return-Path: <duykynguyen@hotmail.com>
Received: from bay0-omc3-s36.bay0.hotmail.com (bay0-omc3-s36.bay0.hotmail.com
	[65.54.246.236]) by ozlabs.org (Postfix) with ESMTP id 63747DDDEC
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  2 Nov 2008 06:24:17 +1100 (EST)
Message-ID: <BLU119-DAV98C08498E7789ECB3DB2CBB230@phx.gbl>
From: "Duy-Ky Nguyen" <duykynguyen@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
References: <mailman.4760.1225488584.3127.linuxppc-embedded@ozlabs.org>
Subject: How to use eth0 of MPC8313E
Date: Sat, 1 Nov 2008 12:24:08 -0700
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Heelo,

I'm responding to my question.

I found there's mismatch in PHY id.

Best Regards,

Duy-Ky

----- Original Message ----- 
From: <linuxppc-embedded-request@ozlabs.org>
To: <linuxppc-embedded@ozlabs.org>
Sent: Friday, October 31, 2008 2:29 PM
Subject: Linuxppc-embedded Digest, Vol 51, Issue 1


> Send Linuxppc-embedded mailing list submissions to
> linuxppc-embedded@ozlabs.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> or, via email, send a message with subject or body 'help' to
> linuxppc-embedded-request@ozlabs.org
>
> You can reach the person managing the list at
> linuxppc-embedded-owner@ozlabs.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Linuxppc-embedded digest..."
>
>
> Today's Topics:
>
>   1. Re: [PATCH] [MPC8313ERDB] Remove duplicate DMA entry from
>      device tree (Kumar Gala)
>   2. Re: Linux 2.6 boot failure on xup virtex II ppc405 (saadia dhouib)
>   3. Re: Linux 2.6 boot failure on xup virtex II ppc405 (Grant Likely)
>   4. How to use eth0 of MPC8313E (Duy-Ky Nguyen)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Fri, 31 Oct 2008 02:39:02 -0500
> From: Kumar Gala <galak@kernel.crashing.org>
> Subject: Re: [PATCH] [MPC8313ERDB] Remove duplicate DMA entry from
> device tree
> To: Mike Dyer <mike.dyer@provision-comm.com>
> Cc: scottwood@freescale.com, Joaquin.Luna@jdsu.com,
> linuxppc-embedded@ozlabs.org
> Message-ID: <847BC9E6-360B-4594-96DB-AF8D6C71D4D1@kernel.crashing.org>
> Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
>
>
> On Oct 29, 2008, at 5:10 AM, Mike Dyer wrote:
>
>>
>> Signed-off-by: Mike Dyer <mike.dyer@provision-comm.com>
>> ---
>> arch/powerpc/boot/dts/mpc8313erdb.dts |   39
>> ---------------------------------
>> 1 files changed, 0 insertions(+), 39 deletions(-)
>
> applied for 2.6.28
>
> - k
>
>
> ------------------------------
>
> Message: 2
> Date: Fri, 31 Oct 2008 09:21:50 -0700 (PDT)
> From: saadia dhouib <saadia_dhouib@yahoo.fr>
> Subject: Re: Linux 2.6 boot failure on xup virtex II ppc405
> To: linuxppc-embedded@ozlabs.org
> Message-ID: <20269333.post@talk.nabble.com>
> Content-Type: text/plain; charset=UTF-8
>
>
> Hi all,
>
> After booting successfully the kernel without a root file system.
>
> I  installed a file system on the flash disk. I used: BusyBox 1.12.1, and
> the script mkrootfs.sh (written by
>
> Wofgang Klingauf) to generate the rfs.
>
>
>
> I changed the boot arg in the kernel configuration as follows:
>
> [*] Default bootloader kernel arguments
> ? ?
>  ? ?                                      (console=ttyUL0,9600
> root=/dev/xsysace/disc0/xsa3 rw) Initial kernel command string
>
>
>
>
>
> Then I rebooted the kernel, and there were those errors :( :
>
>
>
> Linux/PowerPC load: console=ttyUL0,9600 root=/dev/xsysace/disc0/part3 
> ip=on
> Finalizing device tree... flat tree at 0x40ae18
> Using Xilinx Virtex machine description
> Linux version 2.6.27-rc9 (dhouib@lo-lester-030) (gcc version 3.4.5) #19
> PREEMPT Fri Oct 31 15:41:03 CET 2008
> Zone PFN ranges:
>  DMA      0x00000000 -> 0x00010000
>  Normal   0x00010000 -> 0x00010000
> Movable zone start PFN for each node
> early_node_map[1] active PFN ranges
>    0: 0x00000000 -> 0x00010000
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
> Kernel command line: console=ttyUL0,9600 root=/dev/xsysace/disc0/part3 
> ip=on
> Xilinx intc at 0x41200000 mapped to 0xfdfff000
> PID hash table entries: 1024 (order: 10, 4096 bytes)
> clocksource: timebase mult[d55555] shift[22] registered
> Console: colour dummy device 80x25
> console [ttyUL0] enabled
> Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Memory: 257792k/262144k available (1564k kernel code, 4044k reserved, 84k
> data, 89k bss, 76k init)
> Calibrating delay loop... 598.01 BogoMIPS (lpj=1196032)
> Mount-cache hash table entries: 512
> msgmni has been set to 504
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> 40600000.serial: ttyUL0 at MMIO 0x40600003 (irq = 16) is a uartlite
> xsysace 41800000.sysace: Xilinx SystemACE revision 1.0.12
> xsysace 41800000.sysace: capacity: 3940272 sectors
> xsa: xsa1 xsa2 xsa3
> Xilinx SystemACE device driver, major=254
> mice: PS/2 mouse device common for all mice
> VFS: Cannot open root device "xsysace/disc0/part3" or unknown-block(0,0)
> Please append a correct "root=" boot option; here are the available
> partitions:
> fe00    1970136 xsa (driver?)
>  fe01      32098 xsa1
>  fe02     265072 xsa2
>  fe03    1020127 xsa3
> Kernel panic - not syncing: VFS: Unable to mount root fs on
> unknown-block(0,0)
> Rebooting in 180 seconds..<2>init has generated signal 8 but has no 
> handler
> for it
> note: swapper[1] exited with preempt_count 2
> Kernel panic - not syncing: Attempted to kill init!
> Rebooting in 180 seconds..Oops: Exception in kernel mode, sig: 8 [#1]
> PREEMPT Xilinx Virtex
> NIP: cf80ab60 LR: cf81fba0 CTR: 00000000
> REGS: cf81faf0 TRAP: cf81fba0   Not tainted  (2.6.27-rc9)
> MSR: 00000020 <IR>  CR: 44004022  XER: cf80ab68
> TASK = cf814c00[1] 'swapper' THREAD: cf81e000
> GPR00: 44000084 cf81fb50 00000006 c0190000 00029030 c0190000 00000030
> cf81e000
> GPR08: cf81fb20 004ca564 c01a0000 c01a0000 c01621a0 cf81fc58 cf814c00
> cf81fd20
> GPR16: c01a0000 c01648c0 cf814c00 c01a0000 cf81fbc0 c0026428 00000039
> 000000b4
> GPR24: c01a4d70 ffffffff 00000000 000009b8 00000004 00000000 00000000
> c01a0000
> NIP [cf80ab60] 0xcf80ab60
> LR [cf81fba0] 0xcf81fba0
> Call Trace:
> [cf81fb50] [ffffffff] 0xffffffff (unreliable)
> Instruction dump:
> XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
> XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
> ---[ end trace 17f4c6d1c47d3b7d ]---
> Fixing recursive fault but reboot is needed!
> BUG: scheduling while atomic: swapper/1/0x00000003
> Call Trace:
> [cf81f8a0] [c0007704] show_stack+0x40/0x16c (unreliable)
> [cf81f8d0] [c0020150] __schedule_bug+0x64/0x78
> [cf81f8f0] [c013d108] __sched_text_start+0x390/0x3fc
> [cf81f930] [c0027f10] do_exit+0x440/0x7b0
> [cf81f970] [c000b594] _exception+0x0/0x1ac
> [cf81f990] [c000b6a8] _exception+0x114/0x1ac
> [cf81fae0] [c000e0fc] ret_from_except_full+0x0/0x4c
> [cf81fb20] [cf81fc58] 0xcf81fc58
>
>
> Could someone help me please?
>
> Thanks
>
> Saadia
>
>
>
> saadia dhouib wrote:
>>
>> Hi,
>> I have downloaded the latest linux kernel linux-2.6-xlnx.git from
>> http://git.xilinx.com/ .
>> Than I have downloaded the device tree generator  device-tree.git from 
>> the
>> same site.
>> I launched edk 8.2.02, I designed a system with two powerpc cores:
>> ppc_405_0, ppc_405_1, and opb bus , a plb bus, and the following devices
>> with their memory map:
>>
>> BASE         HIGH            MODULE
>> 0x00000000 0x0FFFFFFF DDR_256MB_32MX64_rank1_row13_col10_cl2_5
>> 0x40600000 0x4060FFFF RS232_Uart_1
>> 0x40C00000 0x40C0FFFF Ethernet_MAC
>> 0x41200000 0x4120FFFF opb_intc_0
>> 0x41800000 0x4180FFFF SysACE_CompactFlash
>>
>> I generated the bitsteam system.bit.
>> After getting the device tree generator from
>> git://git.xilinx.com/device-tree.git, I have copied the 'bsp' directory
>> and contents so that it can be used by edk XPS. Then I selected
>> 'device-tree' in the pull down menu labeled 'OS' in the Software Platform
>> Settings dialog box.
>> Then selected 'OS and Libraries' on the left, and entered the values for
>> 'console device' and  'bootargs' (respectively
>> 'RS232_Uart_1' and 'console=ttyS0,9600 root=/dev/xsysace/disc0/part3
>> ip=on' ).
>> Then I generated libraries and  BSP, in the edk_project directory and not
>> in the linux src directory.
>> There were those warnings:
>> *******************************************************************************************************************
>> --- device tree generator version: v1.1 ---
>> generating xilinx.dts
>> Clock Port Summary:
>> ppc405_0.CPMC405CLOCK connected to proc_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> ppc405_0.PLBCLK connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> reset_block.Slowest_sync_clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> plb.PLB_Clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> opb.OPB_Clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>
>> plb2opb.PLB_Clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> plb2opb.OPB_Clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> RS232_Uart_1.OPB_Clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> Ethernet_MAC.OPB_Clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> SysACE_CompactFlash.OPB_Clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> DDR_256MB_32MX64_rank1_row13_col10_cl2_5.PLB_Clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> plb_bram_if_cntlr_1.plb_clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> plb_bram_if_cntlr_1_bram.BRAM_Clk_A connected to
>> plb_bram_if_cntlr_1_port_BRAM_Clk:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> opb_intc_0.OPB_Clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> dcm_0.CLKIN connected to dcm_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> dcm_0.CLK0 connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>     CLK_INPORT = CLKIN
>>     CLK_FACTOR = 1
>> dcm_0.CLK90 connected to clk_90_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>     CLK_INPORT = CLKIN
>>     CLK_FACTOR = 1
>> dcm_0.CLKFX connected to proc_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>     CLK_INPORT = CLKIN
>>     CLK_FACTOR = C_CLKFX_MULTIPLY / C_CLKFX_DIVIDE
>> dcm_1.CLKIN connected to ddr_feedback_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> dcm_1.CLK0 connected to dcm_1_FB:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>     CLK_INPORT = CLKIN
>>     CLK_FACTOR = 1
>> dcm_1.CLK90 connected to ddr_clk_90_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>     CLK_INPORT = CLKIN
>>     CLK_FACTOR = 1
>> Clock Frequency: 300000000
>> IP connected to bus: plb
>> -master DPLB plb ppc405_0
>> -master IPLB plb ppc405_0
>> -slave SPLB plb plb2opb
>> -slave SPLB plb DDR_256MB_32MX64_rank1_row13_col10_cl2_5
>> -slave SPLB plb plb_bram_if_cntlr_1
>> IP connected to bus: opb
>> -master MOPB opb plb2opb
>> -slave SOPB opb RS232_Uart_1
>> -slave SOPB opb Ethernet_MAC
>> -slave SOPB opb SysACE_CompactFlash
>> -slave SOPB opb opb_intc_0
>>
>> WARNING:MDT - Search path /home/dhouib/xupv2p/ directly contains pcores
>>    directory. Search path should point to a directory two levels above
>> pcores.
>> WARNING:MDT - Search path /home/dhouib/xupv2p/ directly contains pcores
>>    directory. Search path should point to a directory two levels above
>> pcores.
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> opb.OPB_Clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> plb2opb.PLB_Clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>
>> plb2opb.OPB_Clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> RS232_Uart_1.OPB_Clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>
>> Ethernet_MAC.OPB_Clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> SysACE_CompactFlash.OPB_Clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> DDR_256MB_32MX64_rank1_row13_col10_cl2_5.PLB_Clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>
>> plb_bram_if_cntlr_1.plb_clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> plb_bram_if_cntlr_1_bram.BRAM_Clk_A connected to
>> plb_bram_if_cntlr_1_port_BRAM_Clk:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> opb_intc_0.OPB_Clk connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> dcm_0.CLKIN connected to dcm_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> dcm_0.CLK0 connected to sys_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>     CLK_INPORT = CLKIN
>>     CLK_FACTOR = 1
>> dcm_0.CLK90 connected to clk_90_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>     CLK_INPORT = CLKIN
>>     CLK_FACTOR = 1
>>
>> dcm_0.CLKFX connected to proc_clk_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>     CLK_INPORT = CLKIN
>>     CLK_FACTOR = C_CLKFX_MULTIPLY / C_CLKFX_DIVIDE
>> dcm_1.CLKIN connected to ddr_feedback_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>> dcm_1.CLK0 connected to dcm_1_FB:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>     CLK_INPORT = CLKIN
>>     CLK_FACTOR = 1
>> dcm_1.CLK90 connected to ddr_clk_90_s:
>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>     CLK_INPORT = CLKIN
>>     CLK_FACTOR = 1
>> Clock Frequency: 300000000
>> IP connected to bus: plb
>> ***************************************************************************************************************
>> ***************************************************************************************************************
>>
>> I copied  <edk_project_path>/ppc_405_0/libsrc/device-tree/xilinx.dts to
>> <linux_path>/arch/powerpc/boot/dts/virtex405-ml405.dts .
>>  the device tree file looks like this:
>> ****************************************************************************************************
>> ****************************************************************************************************
>> /*
>>  * Device Tree Generator version: 1.1
>>  *
>>  * (C) Copyright 2007-2008 Xilinx, Inc.
>>  * (C) Copyright 2007-2008 Michal Simek
>>  *
>>  * Michal SIMEK <monstr@monstr.eu>
>>  *
>>  * This program is free software; you can redistribute it and/or
>>  * modify it under the terms of the GNU General Public License as
>>  * published by the Free Software Foundation; either version 2 of
>>  * the License, or (at your option) any later version.
>>  *
>>  * This program is distributed in the hope that it will be useful,
>>  * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>>  * GNU General Public License for more details.
>>  *
>>  * You should have received a copy of the GNU General Public License
>>  * along with this program; if not, write to the Free Software
>>  * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
>>  * MA 02111-1307 USA
>>  *
>>  * CAUTION: This file is automatically generated by libgen.
>>  * Version: Xilinx EDK 8.2.02 EDK_Im_Sp2.4
>>  *
>>  * XPS project directory: edk_300_100_linux_2-6
>>  */
>>
>> /dts-v1/;
>> / {
>> #address-cells = <1>;
>> #size-cells = <1>;
>> compatible = "xlnx,virtex405", "xlnx,virtex";
>> model = "testing";
>> DDR_256MB_32MX64_rank1_row13_col10_cl2_5: memory@0 {
>> device_type = "memory";
>> reg = < 0x0 0x10000000 >;
>> } ;
>> chosen {
>> bootargs = "console=ttyS0,9600 root=/dev/xsysace/disc0/part3 ip=on";
>> linux,stdout-path = "/plb@0/opb@40000000/serial@40600000";
>> } ;
>> cpus {
>> #address-cells = <1>;
>> #cpus = <0x1>;
>> #size-cells = <0>;
>> ppc405_0: cpu@0 {
>> clock-frequency = <300000000>;
>> compatible = "PowerPC,405", "ibm,ppc405";
>> d-cache-line-size = <0x20>;
>> d-cache-size = <0x4000>;
>> dcr-access-method = "native";
>> dcr-controller ;
>> device_type = "cpu";
>> i-cache-line-size = <0x20>;
>> i-cache-size = <0x4000>;
>> model = "PowerPC,405";
>> reg = <0>;
>> timebase-frequency = <300000000>;
>> xlnx,dcr-resync = <0x0>;
>> xlnx,deterministic-mult = <0x0>;
>> xlnx,disable-operand-forwarding = <0x1>;
>> xlnx,mmu-enable = <0x1>;
>> } ;
>> } ;
>> plb: plb@0 {
>> #address-cells = <1>;
>> #size-cells = <1>;
>> compatible = "xlnx,plb-v34-1.02.a", "simple-bus";
>> ranges ;
>> opb: opb@40000000 {
>> #address-cells = <1>;
>> #size-cells = <1>;
>> compatible = "xlnx,opb-v20-1.10.c", "simple-bus";
>> ranges = < 0x40000000 0x40000000 0x40000000 >;
>> Ethernet_MAC: ethernet@40c00000 {
>> compatible = "xlnx,opb-ethernet-1.04.a";
>> device_type = "network";
>> local-mac-address = [ 02 00 00 00 00 00 ];
>> reg = < 0x40c00000 0x10000 >;
>> xlnx,cam-bram-0-srl-1 = <0x1>;
>> xlnx,cam-exist = <0x0>;
>> xlnx,dev-blk-id = <0x1>;
>> xlnx,dev-mir-enable = <0x1>;
>> xlnx,dma-intr-coalesce = <0x1>;
>> xlnx,dma-present = <0x1>;
>> xlnx,err-count-exist = <0x1>;
>> xlnx,family = "virtex2p";
>> xlnx,fcs-insert-exist = <0x1>;
>> xlnx,half-duplex-exist = <0x1>;
>> xlnx,include-dev-pencoder = <0x1>;
>> xlnx,ipif-rdfifo-depth = <0x8000>;
>> xlnx,ipif-wrfifo-depth = <0x8000>;
>> xlnx,jumbo-exist = <0x0>;
>> xlnx,mac-fifo-bram-1-srl-0 = <0x0>;
>> xlnx,mac-fifo-depth = <0x40>;
>> xlnx,mii-exist = <0x1>;
>> xlnx,miim-clkdvd = <0x1f>;
>> xlnx,pad-insert-exist = <0x1>;
>> xlnx,reset-present = <0x1>;
>> xlnx,rx-dre-type = <0x0>;
>> xlnx,rx-include-csum = <0x0>;
>> xlnx,source-addr-insert-exist = <0x1>;
>> xlnx,tx-dre-type = <0x0>;
>> xlnx,tx-include-csum = <0x0>;
>> } ;
>> RS232_Uart_1: serial@40600000 {
>> clock-frequency = "";
>> compatible = "xlnx,opb-uartlite-1.00.b";
>> current-speed = <9600>;
>> device_type = "serial";
>> interrupt-parent = <&opb_intc_0>;
>> interrupts = < 1 0 >;
>> port-number = <0>;
>> reg = < 0x40600000 0x10000 >;
>> xlnx,baudrate = <0x9600>;
>> xlnx,clk-freq = <0x5f5e100>;
>> xlnx,data-bits = <0x8>;
>> xlnx,odd-parity = <0x0>;
>> xlnx,use-parity = <0x0>;
>> } ;
>> SysACE_CompactFlash: sysace@41800000 {
>> compatible = "xlnx,opb-sysace-1.00.c";
>> interrupt-parent = <&opb_intc_0>;
>> interrupts = < 0 2 >;
>> reg = < 0x41800000 0x10000 >;
>> xlnx,mem-width = <0x10>;
>> } ;
>> opb_intc_0: interrupt-controller@41200000 {
>> #interrupt-cells = <0x2>;
>> compatible = "xlnx,opb-intc-1.00.c";
>> interrupt-controller ;
>> reg = < 0x41200000 0x10000 >;
>> xlnx,num-intr-inputs = <0x2>;
>> } ;
>> } ;
>> } ;
>> }  ;
>> ******************************************************************************************************
>> ******************************************************************************************************
>>
>> Then cp <linux_path>/arch/powerpc/configs/40x/virtex4_defconfig
>> <linux_path>/.
>>
>> Then
>> cd <linux_path>
>> export ARCH=powerpc
>> export CROSS_COMPILE=powerpc-405-linux-gnu-
>> export
>> PATH=${PATH}:$HOME/xupv2p/opt/crosstool/gcc-3.4.5-glibc-2.3.5/powerpc-405-linux-gnu/bin
>> make menuconfig
>> I disabled all the options and enabled only:
>> -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
>> Processor support ->  Processor Type AMCC 40x (!!!  there is not ppc 40x)
>> Platform Support ->  Generic Xilinx Virtex board
>> Kernel options ->   Kernel support for ELF binaries
>>                             Math emulation
>>                            Default bootloader kernel arguments
>>                              (console=ttyS0,9600)    Initial kernel
>> command  string
>>                                      (simpleImage.virtex405-ml405)
>> Additional default image types
>> Device Drivers -> Character Devices -> Virtual Terminal
>>                                                            Serial Devices
>> ->   [*] 8250/16550 and compatible serial
>>
>> [*]   Console on 8250/16550 and compatible serial port
>>
>> (4) Maximum number of 8250/16550 serial ports
>>
>> (4) Number of 8250/16550 serial ports to register at runtime
>>
>> --------------------------------------------------------------------------------------------------------------------------------------------------------------------
>>
>> Then make clean && make dep && make zImage
>> I obtained a binary zImage file (and not zImage.elf) !!!! and I obtained
>> simpleImage.virtex405-ml405.elf in <linux_path>/arch/powerpc/boot .
>>
>> I used xmd to generated a system.ace from the bitstream and the elf.
>> The report of xmd is:
>> ******************************************************************************
>> *****************************************************************************
>> XMD% xmd -tcl genace.tcl -opt genace1.opt
>> Xilinx Microprocessor Debug (XMD) Engine
>> Xilinx EDK 8.2.02 Build EDK_Im_Sp2.4
>> Copyright (c) 1995-2005 Xilinx, Inc.  All rights reserved.
>> Executing user script : genace.tcl
>>
>> #######################################################################
>> XMD GenACE utility. Generate SystemACE File from bit/elf/data Files
>> #######################################################################
>> Using GenACE option file : genace1.opt
>> GenACE Options:
>> Board      : xupv2p
>> Jtag Devs  : xc2vp30
>> FPGA pos   : 1
>> JPROG      : true
>> HW File    :
>> /home/dhouib/xupv2p/edk_300_100_linux_2-6/implementation/system.bit
>> ACE File   : system3.ace
>> nCPUs      : 1
>>
>> Processor ppc_hw_1 Information
>> Debug opt : -debugdevice devicenr 1 cpunr 1
>> ELF files : simpleImage.virtex405-ml405-3.elf
>> Start PC Address : 0x00400000
>>
>> ############################################################
>> Converting Bitstream
>> '/home/dhouib/xupv2p/edk_300_100_linux_2-6/implementation/system.bit' to
>> SVF file
>> '/home/dhouib/xupv2p/edk_300_100_linux_2-6/implementation/system.svf'
>> Executing 'impact -batch bit2svf.scr'
>>
>> Copying
>> /home/dhouib/xupv2p/edk_300_100_linux_2-6/implementation/system.svf File
>> to  system3.svf File
>>
>>
>> ############################################################
>> Converting ELF file 'simpleImage.virtex405-ml405-3.elf' to SVF file
>> 'simpleImage.virtex405-ml405-3.svf'
>> Target reset successfully
>> section, .text: 0x00400000-0x00408ed4
>> section, .data: 0x00409000-0x0040ac18
>> section, __builtin_cmdline: 0x0040ac18-0x0040ae18
>> section, .kernel:dtb: 0x0040ae18-0x0040be33
>> section, .kernel:vmlinux.strip: 0x0040c000-0x004c3ae1
>> section, .bss: 0x004c4000-0x004d0dd8
>> Downloaded Program simpleImage.virtex405-ml405-3.elf
>> Setting PC with program start addr = 0x00400000
>> PC reset to 0x00400000, Clearing MSR Register
>>
>> Copying simpleImage.virtex405-ml405-3.svf File to  system3.svf File
>>
>>
>> ############################################################
>> Writing Processor JTAG "continue" command to SVF file 'sw_suffix.svf'
>> PC reset to 0x00400000, Clearing MSR Register
>> Processor started. Type "stop" to stop processor
>>
>> ############################################################
>> Converting SVF file 'system3.svf' to SystemACE file 'system3.ace'
>> Executing 'impact -batch svf2ace.scr'
>>
>> SystemACE file 'system3.ace' created successfully
>> ********************************************************************************************
>> ********************************************************************************************
>>
>>
>> I copied the system3.ace (3 because it was the third kernel that I tested
>> :((( ) to the flash disk partition 1 (Type = FAT16, Size = 32Mo ).
>> And I booted the kernel.
>> I got fllowing message on the Terminal:
>>
>> *****************************************************************************************
>> zImage starting: loaded at 0x00400000 (sp: 0x004c4efc)
>> Allocating 0x1acdec bytes for kernel ...
>> gunzipping (0x00000000 <- 0x0040c000:0x004c3ae1)...done 0x1951b8 bytes
>>
>> Linux/PowerPC load: console=ttyS0,9600 root=/dev/xsysace/disc0/part3 
>> ip=on
>> Finalizing device tree... flat tree at 0x40ae18
>> *******************************************************************************************
>>
>> My Questions are:
>> 1. Why he stops here?
>> 2. Why I didn't obtained zImage.elf but simpleImage.virtex405-ml405.elf
>> 3. Do I have to copy other files from my <edk_project_path> 
>> (xparameters.h
>> , drivers ) to the <linux_path> ? (I copied only the xilinx.dts file)
>>
>> Thanks
>> saadia
>>
>>
>>
>>
>>
>>
>
> -- 
> View this message in context: 
> http://www.nabble.com/Linux-2.6-boot-failure-on-xup-virtex-II-ppc405-tp20252128p20269333.html
> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
>
>
>
> ------------------------------
>
> Message: 3
> Date: Fri, 31 Oct 2008 10:33:32 -0600
> From: "Grant Likely" <grant.likely@secretlab.ca>
> Subject: Re: Linux 2.6 boot failure on xup virtex II ppc405
> To: "saadia dhouib" <saadia_dhouib@yahoo.fr>
> Cc: linuxppc-embedded@ozlabs.org
> Message-ID:
> <fa686aa40810310933v364b195fx3f84ede9d6fb7fa2@mail.gmail.com>
> Content-Type: text/plain; charset=ISO-8859-1
>
> On Fri, Oct 31, 2008 at 10:21 AM, saadia dhouib <saadia_dhouib@yahoo.fr> 
> wrote:
>>
>> Hi all,
>>
>> After booting successfully the kernel without a root file system.
>>
>> I  installed a file system on the flash disk. I used: BusyBox 1.12.1, and
>> the script mkrootfs.sh (written by
>>
>> Wofgang Klingauf) to generate the rfs.
>
> Looks like you don't have the ext3 driver compiled into your kernel.
>
> g.
>
>
> ------------------------------
>
> Message: 4
> Date: Fri, 31 Oct 2008 14:29:35 -0700
> From: "Duy-Ky Nguyen" <duykynguyen@hotmail.com>
> Subject: How to use eth0 of MPC8313E
> To: <linuxppc-embedded@ozlabs.org>
> Message-ID: <BLU119-DAV645CD008897C8C7315077BB200@phx.gbl>
> Content-Type: text/plain; format=flowed; charset="iso-8859-1";
> reply-type=original
>
> Hello,
>
> It appears to me that the FreeScale Eva Board MPC8313E-RDB has 2 ethernet
> controllers TSEC1 and TSEC2 for 6 ethernet connectors G0 ~ G5. The TSEC1 
> is
> connected to Vistesse L2 switch VSC for G0 ~ G4. The TSEC2 is for G5.
>
> I've been using G5 as eth1 only as I have to use firmware for using the
> others.
>
> Now I have my own prototype using only TSEC1 while TSEC2 pins used as
> GPIO's.
> I'm able to do u-boot but eth0 is not working as I'm not able to ping from
> u-boot to the host. I have correct PhyAddr for the PHY chip.
>
> I'm really appreciate your time and help..
>
> Best Regards,
>
> Duy-Ky
>
> ----- Original Message ----- 
> From: <linuxppc-embedded-request@ozlabs.org>
> To: <linuxppc-embedded@ozlabs.org>
> Sent: Thursday, October 30, 2008 11:11 AM
> Subject: Linuxppc-embedded Digest, Vol 50, Issue 47
>
>
>> Send Linuxppc-embedded mailing list submissions to
>> linuxppc-embedded@ozlabs.org
>>
>> To subscribe or unsubscribe via the World Wide Web, visit
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>> or, via email, send a message with subject or body 'help' to
>> linuxppc-embedded-request@ozlabs.org
>>
>> You can reach the person managing the list at
>> linuxppc-embedded-owner@ozlabs.org
>>
>> When replying, please edit your Subject line so it is more specific
>> than "Re: Contents of Linuxppc-embedded digest..."
>>
>>
>> Today's Topics:
>>
>>   1. Linux 2.6 boot failure on xup virtex II ppc405 (saadia)
>>   2. RE: Linux 2.6 boot failure on xup virtex II ppc405
>>      (Stephen Neuendorffer)
>>
>>
>> ----------------------------------------------------------------------
>>
>> Message: 1
>> Date: Thu, 30 Oct 2008 10:56:36 -0700 (PDT)
>> From: saadia <saadia_dhouib@yahoo.fr>
>> Subject: Linux 2.6 boot failure on xup virtex II ppc405
>> To: linuxppc-embedded@ozlabs.org
>> Message-ID: <20252128.post@talk.nabble.com>
>> Content-Type: text/plain; charset=us-ascii
>>
>>
>> Hi,
>> I have downloaded the latest linux kernel linux-2.6-xlnx.git from
>> http://git.xilinx.com/ .
>> Than I have downloaded the device tree generator  device-tree.git from 
>> the
>> same site.
>> I launched edk 8.2.02, I designed a system with two powerpc cores:
>> ppc_405_0, ppc_405_1, and opb bus , a plb bus, and the following devices
>> with their memory map:
>>
>> BASE         HIGH            MODULE
>> 0x00000000 0x0FFFFFFF DDR_256MB_32MX64_rank1_row13_col10_cl2_5
>> 0x40600000 0x4060FFFF RS232_Uart_1
>> 0x40C00000 0x40C0FFFF Ethernet_MAC
>> 0x41200000 0x4120FFFF opb_intc_0
>> 0x41800000 0x4180FFFF SysACE_CompactFlash
>>
>> I generated the bitsteam system.bit.
>> After getting the device tree generator from
>> git://git.xilinx.com/device-tree.git, I have copied the 'bsp' directory
>> and
>> contents so that it can be used by edk XPS. Then I selected 'device-tree'
>> in
>> the pull down menu labeled 'OS' in the Software Platform Settings dialog
>> box.
>> Then selected 'OS and Libraries' on the left, and entered the values for
>> 'console device' and  'bootargs' (respectively
>> 'RS232_Uart_1' and 'console=ttyS0,9600 root=/dev/xsysace/disc0/part3
>> ip=on'
>> ).
>> Then I generated libraries and  BSP, in the edk_project directory and not
>> in
>> the linux src directory.
>> There were those warnings:
>> *******************************************************************************************************************
>> --- device tree generator version: v1.1 ---
>> generating xilinx.dts
>> Clock Port Summary:
>> ppc405_0.CPMC405CLOCK connected to proc_clk_s:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>> ppc405_0.PLBCLK connected to sys_clk_s:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>> reset_block.Slowest_sync_clk connected to sys_clk_s:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>> plb.PLB_Clk connected to sys_clk_s:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>> opb.OPB_Clk connected to sys_clk_s:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>>
>> plb2opb.PLB_Clk connected to sys_clk_s:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>> plb2opb.OPB_Clk connected to sys_clk_s:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>> RS232_Uart_1.OPB_Clk connected to sys_clk_s:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>> Ethernet_MAC.OPB_Clk connected to sys_clk_s:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>> SysACE_CompactFlash.OPB_Clk connected to sys_clk_s:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>> DDR_256MB_32MX64_rank1_row13_col10_cl2_5.PLB_Clk connected to sys_clk_s:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>> plb_bram_if_cntlr_1.plb_clk connected to sys_clk_s:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>> plb_bram_if_cntlr_1_bram.BRAM_Clk_A connected to
>> plb_bram_if_cntlr_1_port_BRAM_Clk:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>> opb_intc_0.OPB_Clk connected to sys_clk_s:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>> dcm_0.CLKIN connected to dcm_clk_s:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>> dcm_0.CLK0 connected to sys_clk_s:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>>    CLK_INPORT = CLKIN
>>    CLK_FACTOR = 1
>> dcm_0.CLK90 connected to clk_90_s:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>>    CLK_INPORT = CLKIN
>>    CLK_FACTOR = 1
>> dcm_0.CLKFX connected to proc_clk_s:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>>    CLK_INPORT = CLKIN
>>    CLK_FACTOR = C_CLKFX_MULTIPLY / C_CLKFX_DIVIDE
>> dcm_1.CLKIN connected to ddr_feedback_s:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>> dcm_1.CLK0 connected to dcm_1_FB:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>>    CLK_INPORT = CLKIN
>>    CLK_FACTOR = 1
>> dcm_1.CLK90 connected to ddr_clk_90_s:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>>    CLK_INPORT = CLKIN
>>    CLK_FACTOR = 1
>> Clock Frequency: 300000000
>> IP connected to bus: plb
>> -master DPLB plb ppc405_0
>> -master IPLB plb ppc405_0
>> -slave SPLB plb plb2opb
>> -slave SPLB plb DDR_256MB_32MX64_rank1_row13_col10_cl2_5
>> -slave SPLB plb plb_bram_if_cntlr_1
>> IP connected to bus: opb
>> -master MOPB opb plb2opb
>> -slave SOPB opb RS232_Uart_1
>> -slave SOPB opb Ethernet_MAC
>> -slave SOPB opb SysACE_CompactFlash
>> -slave SOPB opb opb_intc_0
>>
>> WARNING:MDT - Search path /home/dhouib/xupv2p/ directly contains pcores
>>   directory. Search path should point to a directory two levels above
>> pcores.
>> WARNING:MDT - Search path /home/dhouib/xupv2p/ directly contains pcores
>>   directory. Search path should point to a directory two levels above
>> pcores.
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>>
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>>
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>>
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>> opb.OPB_Clk connected to sys_clk_s:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>> plb2opb.PLB_Clk connected to sys_clk_s:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>>
>> plb2opb.OPB_Clk connected to sys_clk_s:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>> RS232_Uart_1.OPB_Clk connected to sys_clk_s:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>>
>> Ethernet_MAC.OPB_Clk connected to sys_clk_s:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>> SysACE_CompactFlash.OPB_Clk connected to sys_clk_s:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>> DDR_256MB_32MX64_rank1_row13_col10_cl2_5.PLB_Clk connected to sys_clk_s:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>>
>> plb_bram_if_cntlr_1.plb_clk connected to sys_clk_s:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>> plb_bram_if_cntlr_1_bram.BRAM_Clk_A connected to
>> plb_bram_if_cntlr_1_port_BRAM_Clk:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>> opb_intc_0.OPB_Clk connected to sys_clk_s:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>> dcm_0.CLKIN connected to dcm_clk_s:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>> dcm_0.CLK0 connected to sys_clk_s:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>>    CLK_INPORT = CLKIN
>>    CLK_FACTOR = 1
>> dcm_0.CLK90 connected to clk_90_s:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>>    CLK_INPORT = CLKIN
>>    CLK_FACTOR = 1
>>
>> dcm_0.CLKFX connected to proc_clk_s:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>>    CLK_INPORT = CLKIN
>>    CLK_FACTOR = C_CLKFX_MULTIPLY / C_CLKFX_DIVIDE
>> dcm_1.CLKIN connected to ddr_feedback_s:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>> dcm_1.CLK0 connected to dcm_1_FB:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>>    CLK_INPORT = CLKIN
>>    CLK_FACTOR = 1
>> dcm_1.CLK90 connected to ddr_clk_90_s:
>>    CLK_FREQ_HZ = WARNING: no frequency found!
>>    CLK_INPORT = CLKIN
>>    CLK_FACTOR = 1
>> Clock Frequency: 300000000
>> IP connected to bus: plb
>> ***************************************************************************************************************
>> ***************************************************************************************************************
>>
>> I copied  <edk_project_path>/ppc_405_0/libsrc/device-tree/xilinx.dts to
>> <linux_path>/arch/powerpc/boot/dts/virtex405-ml405.dts .
>> the device tree file looks like this:
>> ****************************************************************************************************
>> ****************************************************************************************************
>> /*
>> * Device Tree Generator version: 1.1
>> *
>> * (C) Copyright 2007-2008 Xilinx, Inc.
>> * (C) Copyright 2007-2008 Michal Simek
>> *
>> * Michal SIMEK <monstr@monstr.eu>
>> *
>> * This program is free software; you can redistribute it and/or
>> * modify it under the terms of the GNU General Public License as
>> * published by the Free Software Foundation; either version 2 of
>> * the License, or (at your option) any later version.
>> *
>> * This program is distributed in the hope that it will be useful,
>> * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>> * GNU General Public License for more details.
>> *
>> * You should have received a copy of the GNU General Public License
>> * along with this program; if not, write to the Free Software
>> * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
>> * MA 02111-1307 USA
>> *
>> * CAUTION: This file is automatically generated by libgen.
>> * Version: Xilinx EDK 8.2.02 EDK_Im_Sp2.4
>> *
>> * XPS project directory: edk_300_100_linux_2-6
>> */
>>
>> /dts-v1/;
>> / {
>> #address-cells = <1>;
>> #size-cells = <1>;
>> compatible = "xlnx,virtex405", "xlnx,virtex";
>> model = "testing";
>> DDR_256MB_32MX64_rank1_row13_col10_cl2_5: memory@0 {
>> device_type = "memory";
>> reg = < 0x0 0x10000000 >;
>> } ;
>> chosen {
>> bootargs = "console=ttyS0,9600 root=/dev/xsysace/disc0/part3 ip=on";
>> linux,stdout-path = "/plb@0/opb@40000000/serial@40600000";
>> } ;
>> cpus {
>> #address-cells = <1>;
>> #cpus = <0x1>;
>> #size-cells = <0>;
>> ppc405_0: cpu@0 {
>> clock-frequency = <300000000>;
>> compatible = "PowerPC,405", "ibm,ppc405";
>> d-cache-line-size = <0x20>;
>> d-cache-size = <0x4000>;
>> dcr-access-method = "native";
>> dcr-controller ;
>> device_type = "cpu";
>> i-cache-line-size = <0x20>;
>> i-cache-size = <0x4000>;
>> model = "PowerPC,405";
>> reg = <0>;
>> timebase-frequency = <300000000>;
>> xlnx,dcr-resync = <0x0>;
>> xlnx,deterministic-mult = <0x0>;
>> xlnx,disable-operand-forwarding = <0x1>;
>> xlnx,mmu-enable = <0x1>;
>> } ;
>> } ;
>> plb: plb@0 {
>> #address-cells = <1>;
>> #size-cells = <1>;
>> compatible = "xlnx,plb-v34-1.02.a", "simple-bus";
>> ranges ;
>> opb: opb@40000000 {
>> #address-cells = <1>;
>> #size-cells = <1>;
>> compatible = "xlnx,opb-v20-1.10.c", "simple-bus";
>> ranges = < 0x40000000 0x40000000 0x40000000 >;
>> Ethernet_MAC: ethernet@40c00000 {
>> compatible = "xlnx,opb-ethernet-1.04.a";
>> device_type = "network";
>> local-mac-address = [ 02 00 00 00 00 00 ];
>> reg = < 0x40c00000 0x10000 >;
>> xlnx,cam-bram-0-srl-1 = <0x1>;
>> xlnx,cam-exist = <0x0>;
>> xlnx,dev-blk-id = <0x1>;
>> xlnx,dev-mir-enable = <0x1>;
>> xlnx,dma-intr-coalesce = <0x1>;
>> xlnx,dma-present = <0x1>;
>> xlnx,err-count-exist = <0x1>;
>> xlnx,family = "virtex2p";
>> xlnx,fcs-insert-exist = <0x1>;
>> xlnx,half-duplex-exist = <0x1>;
>> xlnx,include-dev-pencoder = <0x1>;
>> xlnx,ipif-rdfifo-depth = <0x8000>;
>> xlnx,ipif-wrfifo-depth = <0x8000>;
>> xlnx,jumbo-exist = <0x0>;
>> xlnx,mac-fifo-bram-1-srl-0 = <0x0>;
>> xlnx,mac-fifo-depth = <0x40>;
>> xlnx,mii-exist = <0x1>;
>> xlnx,miim-clkdvd = <0x1f>;
>> xlnx,pad-insert-exist = <0x1>;
>> xlnx,reset-present = <0x1>;
>> xlnx,rx-dre-type = <0x0>;
>> xlnx,rx-include-csum = <0x0>;
>> xlnx,source-addr-insert-exist = <0x1>;
>> xlnx,tx-dre-type = <0x0>;
>> xlnx,tx-include-csum = <0x0>;
>> } ;
>> RS232_Uart_1: serial@40600000 {
>> clock-frequency = "";
>> compatible = "xlnx,opb-uartlite-1.00.b";
>> current-speed = <9600>;
>> device_type = "serial";
>> interrupt-parent = <&opb_intc_0>;
>> interrupts = < 1 0 >;
>> port-number = <0>;
>> reg = < 0x40600000 0x10000 >;
>> xlnx,baudrate = <0x9600>;
>> xlnx,clk-freq = <0x5f5e100>;
>> xlnx,data-bits = <0x8>;
>> xlnx,odd-parity = <0x0>;
>> xlnx,use-parity = <0x0>;
>> } ;
>> SysACE_CompactFlash: sysace@41800000 {
>> compatible = "xlnx,opb-sysace-1.00.c";
>> interrupt-parent = <&opb_intc_0>;
>> interrupts = < 0 2 >;
>> reg = < 0x41800000 0x10000 >;
>> xlnx,mem-width = <0x10>;
>> } ;
>> opb_intc_0: interrupt-controller@41200000 {
>> #interrupt-cells = <0x2>;
>> compatible = "xlnx,opb-intc-1.00.c";
>> interrupt-controller ;
>> reg = < 0x41200000 0x10000 >;
>> xlnx,num-intr-inputs = <0x2>;
>> } ;
>> } ;
>> } ;
>> }  ;
>> ******************************************************************************************************
>> ******************************************************************************************************
>>
>> Then cp <linux_path>/arch/powerpc/configs/40x/virtex4_defconfig
>> <linux_path>/.
>>
>> Then
>> cd <linux_path>
>> export ARCH=powerpc
>> export CROSS_COMPILE=powerpc-405-linux-gnu-
>> export
>> PATH=${PATH}:$HOME/xupv2p/opt/crosstool/gcc-3.4.5-glibc-2.3.5/powerpc-405-linux-gnu/bin
>> make menuconfig
>> I disabled all the options and enabled only:
>> -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
>> Processor support ->  Processor Type AMCC 40x (!!!  there is not ppc 40x)
>> Platform Support ->  Generic Xilinx Virtex board
>> Kernel options ->   Kernel support for ELF binaries
>>                            Math emulation
>>                           Default bootloader kernel arguments
>>                             (console=ttyS0,9600)    Initial kernel 
>> command
>> string
>>                                     (simpleImage.virtex405-ml405)
>> Additional default image types
>> Device Drivers -> Character Devices -> Virtual Terminal
>>                                                           Serial
>> Devices ->
>> [*] 8250/16550 and compatible serial
>>
>> [*]   Console on 8250/16550 and compatible serial port
>>
>> (4) Maximum number of 8250/16550 serial ports
>>
>> (4) Number of 8250/16550 serial ports to register at runtime
>>
>> --------------------------------------------------------------------------------------------------------------------------------------------------------------------
>>
>> Then make clean && make dep && make zImage
>> I obtained a binary zImage file (and not zImage.elf) !!!! and I obtained
>> simpleImage.virtex405-ml405.elf in <linux_path>/arch/powerpc/boot .
>>
>> I used xmd to generated a system.ace from the bitstream and the elf.
>> The report of xmd is:
>> ******************************************************************************
>> *****************************************************************************
>> XMD% xmd -tcl genace.tcl -opt genace1.opt
>> Xilinx Microprocessor Debug (XMD) Engine
>> Xilinx EDK 8.2.02 Build EDK_Im_Sp2.4
>> Copyright (c) 1995-2005 Xilinx, Inc.  All rights reserved.
>> Executing user script : genace.tcl
>>
>> #######################################################################
>> XMD GenACE utility. Generate SystemACE File from bit/elf/data Files
>> #######################################################################
>> Using GenACE option file : genace1.opt
>> GenACE Options:
>> Board      : xupv2p
>> Jtag Devs  : xc2vp30
>> FPGA pos   : 1
>> JPROG      : true
>> HW File    :
>> /home/dhouib/xupv2p/edk_300_100_linux_2-6/implementation/system.bit
>> ACE File   : system3.ace
>> nCPUs      : 1
>>
>> Processor ppc_hw_1 Information
>> Debug opt : -debugdevice devicenr 1 cpunr 1
>> ELF files : simpleImage.virtex405-ml405-3.elf
>> Start PC Address : 0x00400000
>>
>> ############################################################
>> Converting Bitstream
>> '/home/dhouib/xupv2p/edk_300_100_linux_2-6/implementation/system.bit' to
>> SVF
>> file 
>> '/home/dhouib/xupv2p/edk_300_100_linux_2-6/implementation/system.svf'
>> Executing 'impact -batch bit2svf.scr'
>>
>> Copying
>> /home/dhouib/xupv2p/edk_300_100_linux_2-6/implementation/system.svf
>> File to  system3.svf File
>>
>>
>> ############################################################
>> Converting ELF file 'simpleImage.virtex405-ml405-3.elf' to SVF file
>> 'simpleImage.virtex405-ml405-3.svf'
>> Target reset successfully
>> section, .text: 0x00400000-0x00408ed4
>> section, .data: 0x00409000-0x0040ac18
>> section, __builtin_cmdline: 0x0040ac18-0x0040ae18
>> section, .kernel:dtb: 0x0040ae18-0x0040be33
>> section, .kernel:vmlinux.strip: 0x0040c000-0x004c3ae1
>> section, .bss: 0x004c4000-0x004d0dd8
>> Downloaded Program simpleImage.virtex405-ml405-3.elf
>> Setting PC with program start addr = 0x00400000
>> PC reset to 0x00400000, Clearing MSR Register
>>
>> Copying simpleImage.virtex405-ml405-3.svf File to  system3.svf File
>>
>>
>> ############################################################
>> Writing Processor JTAG "continue" command to SVF file 'sw_suffix.svf'
>> PC reset to 0x00400000, Clearing MSR Register
>> Processor started. Type "stop" to stop processor
>>
>> ############################################################
>> Converting SVF file 'system3.svf' to SystemACE file 'system3.ace'
>> Executing 'impact -batch svf2ace.scr'
>>
>> SystemACE file 'system3.ace' created successfully
>> ********************************************************************************************
>> ********************************************************************************************
>>
>>
>> I copied the system3.ace (3 because it was the third kernel that I tested
>> :((( ) to the flash disk partition 1 (Type = FAT16, Size = 32Mo ).
>> And I booted the kernel.
>> I got fllowing message on the Terminal:
>>
>> *****************************************************************************************
>> zImage starting: loaded at 0x00400000 (sp: 0x004c4efc)
>> Allocating 0x1acdec bytes for kernel ...
>> gunzipping (0x00000000 <- 0x0040c000:0x004c3ae1)...done 0x1951b8 bytes
>>
>> Linux/PowerPC load: console=ttyS0,9600 root=/dev/xsysace/disc0/part3 
>> ip=on
>> Finalizing device tree... flat tree at 0x40ae18
>> *******************************************************************************************
>>
>> My Questions are:
>> 1. Why he stops here?
>> 2. Why I didn't obtained zImage.elf but simpleImage.virtex405-ml405.elf
>> 3. Do I have to copy other files from my <edk_project_path> 
>> (xparameters.h
>> ,
>> drivers ) to the <linux_path> ? (I copied only the xilinx.dts file)
>>
>> Thanks
>> saadia
>>
>>
>>
>>
>>
>> -- 
>> View this message in context:
>> http://www.nabble.com/Linux-2.6-boot-failure-on-xup-virtex-II-ppc405-tp20252128p20252128.html
>> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
>>
>>
>>
>> ------------------------------
>>
>> Message: 2
>> Date: Thu, 30 Oct 2008 11:11:15 -0700
>> From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
>> Subject: RE: Linux 2.6 boot failure on xup virtex II ppc405
>> To: "saadia" <saadia_dhouib@yahoo.fr>, <linuxppc-embedded@ozlabs.org>
>> Message-ID: <20081030181118.5D5E1A38050@mail57-sin.bigfish.com>
>> Content-Type: text/plain; charset="us-ascii"
>>
>>
>> Saadia,
>>
>> I'm guessing that the kernel does not have the right clock information
>> in your device tree.  The quick fix is to fix the clock-frequency
>> attribute on the uart.  The kernel needs this in order to set the
>> register values in the uart correctly.
>>
>> This information would be populated automatically, if you used a
>> somewhat recent version of EDK ( >= 10.1 ) and add a CLOCK_FREQUENCY
>> attribute on the external clock pin in the mhs file.
>>
>> I'm actually somewhat surprised you see any output on the serial port at
>> all.
>>
>> Steve
>>
>>> -----Original Message-----
>>> From: linuxppc-embedded-bounces+stephen=neuendorffer.name@ozlabs.org
>> [mailto:linuxppc-embedded-
>>> bounces+stephen=neuendorffer.name@ozlabs.org] On Behalf Of saadia
>>> Sent: Thursday, October 30, 2008 10:57 AM
>>> To: linuxppc-embedded@ozlabs.org
>>> Subject: Linux 2.6 boot failure on xup virtex II ppc405
>>>
>>>
>>> Hi,
>>> I have downloaded the latest linux kernel linux-2.6-xlnx.git from
>>> http://git.xilinx.com/ .
>>> Than I have downloaded the device tree generator  device-tree.git from
>> the
>>> same site.
>>> I launched edk 8.2.02, I designed a system with two powerpc cores:
>>> ppc_405_0, ppc_405_1, and opb bus , a plb bus, and the following
>> devices
>>> with their memory map:
>>>
>>> BASE         HIGH            MODULE
>>> 0x00000000 0x0FFFFFFF DDR_256MB_32MX64_rank1_row13_col10_cl2_5
>>> 0x40600000 0x4060FFFF RS232_Uart_1
>>> 0x40C00000 0x40C0FFFF Ethernet_MAC
>>> 0x41200000 0x4120FFFF opb_intc_0
>>> 0x41800000 0x4180FFFF SysACE_CompactFlash
>>>
>>> I generated the bitsteam system.bit.
>>> After getting the device tree generator from
>>> git://git.xilinx.com/device-tree.git, I have copied the 'bsp'
>> directory and
>>> contents so that it can be used by edk XPS. Then I selected
>> 'device-tree' in
>>> the pull down menu labeled 'OS' in the Software Platform Settings
>> dialog
>>> box.
>>> Then selected 'OS and Libraries' on the left, and entered the values
>> for
>>> 'console device' and  'bootargs' (respectively
>>> 'RS232_Uart_1' and 'console=ttyS0,9600 root=/dev/xsysace/disc0/part3
>> ip=on'
>>> ).
>>> Then I generated libraries and  BSP, in the edk_project directory and
>> not in
>>> the linux src directory.
>>> There were those warnings:
>>>
>> ************************************************************************
>> *****************************
>>> **************
>>> --- device tree generator version: v1.1 ---
>>> generating xilinx.dts
>>> Clock Port Summary:
>>> ppc405_0.CPMC405CLOCK connected to proc_clk_s:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>> ppc405_0.PLBCLK connected to sys_clk_s:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>> reset_block.Slowest_sync_clk connected to sys_clk_s:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>> plb.PLB_Clk connected to sys_clk_s:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>> opb.OPB_Clk connected to sys_clk_s:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>>
>>> plb2opb.PLB_Clk connected to sys_clk_s:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>> plb2opb.OPB_Clk connected to sys_clk_s:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>> RS232_Uart_1.OPB_Clk connected to sys_clk_s:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>> Ethernet_MAC.OPB_Clk connected to sys_clk_s:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>> SysACE_CompactFlash.OPB_Clk connected to sys_clk_s:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>> DDR_256MB_32MX64_rank1_row13_col10_cl2_5.PLB_Clk connected to
>> sys_clk_s:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>> plb_bram_if_cntlr_1.plb_clk connected to sys_clk_s:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>> plb_bram_if_cntlr_1_bram.BRAM_Clk_A connected to
>>> plb_bram_if_cntlr_1_port_BRAM_Clk:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>> opb_intc_0.OPB_Clk connected to sys_clk_s:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>> dcm_0.CLKIN connected to dcm_clk_s:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>> dcm_0.CLK0 connected to sys_clk_s:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>>     CLK_INPORT = CLKIN
>>>     CLK_FACTOR = 1
>>> dcm_0.CLK90 connected to clk_90_s:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>>     CLK_INPORT = CLKIN
>>>     CLK_FACTOR = 1
>>> dcm_0.CLKFX connected to proc_clk_s:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>>     CLK_INPORT = CLKIN
>>>     CLK_FACTOR = C_CLKFX_MULTIPLY / C_CLKFX_DIVIDE
>>> dcm_1.CLKIN connected to ddr_feedback_s:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>> dcm_1.CLK0 connected to dcm_1_FB:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>>     CLK_INPORT = CLKIN
>>>     CLK_FACTOR = 1
>>> dcm_1.CLK90 connected to ddr_clk_90_s:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>>     CLK_INPORT = CLKIN
>>>     CLK_FACTOR = 1
>>> Clock Frequency: 300000000
>>> IP connected to bus: plb
>>> -master DPLB plb ppc405_0
>>> -master IPLB plb ppc405_0
>>> -slave SPLB plb plb2opb
>>> -slave SPLB plb DDR_256MB_32MX64_rank1_row13_col10_cl2_5
>>> -slave SPLB plb plb_bram_if_cntlr_1
>>> IP connected to bus: opb
>>> -master MOPB opb plb2opb
>>> -slave SOPB opb RS232_Uart_1
>>> -slave SOPB opb Ethernet_MAC
>>> -slave SOPB opb SysACE_CompactFlash
>>> -slave SOPB opb opb_intc_0
>>>
>>> WARNING:MDT - Search path /home/dhouib/xupv2p/ directly contains
>> pcores
>>>    directory. Search path should point to a directory two levels above
>>> pcores.
>>> WARNING:MDT - Search path /home/dhouib/xupv2p/ directly contains
>> pcores
>>>    directory. Search path should point to a directory two levels above
>>> pcores.
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>>
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>>
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>>
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>> opb.OPB_Clk connected to sys_clk_s:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>> plb2opb.PLB_Clk connected to sys_clk_s:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>>
>>> plb2opb.OPB_Clk connected to sys_clk_s:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>> RS232_Uart_1.OPB_Clk connected to sys_clk_s:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>>
>>> Ethernet_MAC.OPB_Clk connected to sys_clk_s:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>> SysACE_CompactFlash.OPB_Clk connected to sys_clk_s:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>> DDR_256MB_32MX64_rank1_row13_col10_cl2_5.PLB_Clk connected to
>> sys_clk_s:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>>
>>> plb_bram_if_cntlr_1.plb_clk connected to sys_clk_s:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>> plb_bram_if_cntlr_1_bram.BRAM_Clk_A connected to
>>> plb_bram_if_cntlr_1_port_BRAM_Clk:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>> opb_intc_0.OPB_Clk connected to sys_clk_s:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>> dcm_0.CLKIN connected to dcm_clk_s:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>> dcm_0.CLK0 connected to sys_clk_s:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>>     CLK_INPORT = CLKIN
>>>     CLK_FACTOR = 1
>>> dcm_0.CLK90 connected to clk_90_s:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>>     CLK_INPORT = CLKIN
>>>     CLK_FACTOR = 1
>>>
>>> dcm_0.CLKFX connected to proc_clk_s:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>>     CLK_INPORT = CLKIN
>>>     CLK_FACTOR = C_CLKFX_MULTIPLY / C_CLKFX_DIVIDE
>>> dcm_1.CLKIN connected to ddr_feedback_s:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>> dcm_1.CLK0 connected to dcm_1_FB:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>>     CLK_INPORT = CLKIN
>>>     CLK_FACTOR = 1
>>> dcm_1.CLK90 connected to ddr_clk_90_s:
>>>     CLK_FREQ_HZ = WARNING: no frequency found!
>>>     CLK_INPORT = CLKIN
>>>     CLK_FACTOR = 1
>>> Clock Frequency: 300000000
>>> IP connected to bus: plb
>>>
>> ************************************************************************
>> *****************************
>>> **********
>>>
>> ************************************************************************
>> *****************************
>>> **********
>>>
>>> I copied  <edk_project_path>/ppc_405_0/libsrc/device-tree/xilinx.dts
>> to
>>> <linux_path>/arch/powerpc/boot/dts/virtex405-ml405.dts .
>>>  the device tree file looks like this:
>>>
>> ************************************************************************
>> ****************************
>>>
>> ************************************************************************
>> ****************************
>>> /*
>>>  * Device Tree Generator version: 1.1
>>>  *
>>>  * (C) Copyright 2007-2008 Xilinx, Inc.
>>>  * (C) Copyright 2007-2008 Michal Simek
>>>  *
>>>  * Michal SIMEK <monstr@monstr.eu>
>>>  *
>>>  * This program is free software; you can redistribute it and/or
>>>  * modify it under the terms of the GNU General Public License as
>>>  * published by the Free Software Foundation; either version 2 of
>>>  * the License, or (at your option) any later version.
>>>  *
>>>  * This program is distributed in the hope that it will be useful,
>>>  * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>>>  * GNU General Public License for more details.
>>>  *
>>>  * You should have received a copy of the GNU General Public License
>>>  * along with this program; if not, write to the Free Software
>>>  * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
>>>  * MA 02111-1307 USA
>>>  *
>>>  * CAUTION: This file is automatically generated by libgen.
>>>  * Version: Xilinx EDK 8.2.02 EDK_Im_Sp2.4
>>>  *
>>>  * XPS project directory: edk_300_100_linux_2-6
>>>  */
>>>
>>> /dts-v1/;
>>> / {
>>> #address-cells = <1>;
>>> #size-cells = <1>;
>>> compatible = "xlnx,virtex405", "xlnx,virtex";
>>> model = "testing";
>>> DDR_256MB_32MX64_rank1_row13_col10_cl2_5: memory@0 {
>>> device_type = "memory";
>>> reg = < 0x0 0x10000000 >;
>>> } ;
>>> chosen {
>>> bootargs = "console=ttyS0,9600
>> root=/dev/xsysace/disc0/part3 ip=on";
>>> linux,stdout-path =
>> "/plb@0/opb@40000000/serial@40600000";
>>> } ;
>>> cpus {
>>> #address-cells = <1>;
>>> #cpus = <0x1>;
>>> #size-cells = <0>;
>>> ppc405_0: cpu@0 {
>>> clock-frequency = <300000000>;
>>> compatible = "PowerPC,405", "ibm,ppc405";
>>> d-cache-line-size = <0x20>;
>>> d-cache-size = <0x4000>;
>>> dcr-access-method = "native";
>>> dcr-controller ;
>>> device_type = "cpu";
>>> i-cache-line-size = <0x20>;
>>> i-cache-size = <0x4000>;
>>> model = "PowerPC,405";
>>> reg = <0>;
>>> timebase-frequency = <300000000>;
>>> xlnx,dcr-resync = <0x0>;
>>> xlnx,deterministic-mult = <0x0>;
>>> xlnx,disable-operand-forwarding = <0x1>;
>>> xlnx,mmu-enable = <0x1>;
>>> } ;
>>> } ;
>>> plb: plb@0 {
>>> #address-cells = <1>;
>>> #size-cells = <1>;
>>> compatible = "xlnx,plb-v34-1.02.a", "simple-bus";
>>> ranges ;
>>> opb: opb@40000000 {
>>> #address-cells = <1>;
>>> #size-cells = <1>;
>>> compatible = "xlnx,opb-v20-1.10.c",
>> "simple-bus";
>>> ranges = < 0x40000000 0x40000000 0x40000000 >;
>>> Ethernet_MAC: ethernet@40c00000 {
>>> compatible = "xlnx,opb-ethernet-1.04.a";
>>> device_type = "network";
>>> local-mac-address = [ 02 00 00 00 00 00
>> ];
>>> reg = < 0x40c00000 0x10000 >;
>>> xlnx,cam-bram-0-srl-1 = <0x1>;
>>> xlnx,cam-exist = <0x0>;
>>> xlnx,dev-blk-id = <0x1>;
>>> xlnx,dev-mir-enable = <0x1>;
>>> xlnx,dma-intr-coalesce = <0x1>;
>>> xlnx,dma-present = <0x1>;
>>> xlnx,err-count-exist = <0x1>;
>>> xlnx,family = "virtex2p";
>>> xlnx,fcs-insert-exist = <0x1>;
>>> xlnx,half-duplex-exist = <0x1>;
>>> xlnx,include-dev-pencoder = <0x1>;
>>> xlnx,ipif-rdfifo-depth = <0x8000>;
>>> xlnx,ipif-wrfifo-depth = <0x8000>;
>>> xlnx,jumbo-exist = <0x0>;
>>> xlnx,mac-fifo-bram-1-srl-0 = <0x0>;
>>> xlnx,mac-fifo-depth = <0x40>;
>>> xlnx,mii-exist = <0x1>;
>>> xlnx,miim-clkdvd = <0x1f>;
>>> xlnx,pad-insert-exist = <0x1>;
>>> xlnx,reset-present = <0x1>;
>>> xlnx,rx-dre-type = <0x0>;
>>> xlnx,rx-include-csum = <0x0>;
>>> xlnx,source-addr-insert-exist = <0x1>;
>>> xlnx,tx-dre-type = <0x0>;
>>> xlnx,tx-include-csum = <0x0>;
>>> } ;
>>> RS232_Uart_1: serial@40600000 {
>>> clock-frequency = "";
>>> compatible = "xlnx,opb-uartlite-1.00.b";
>>> current-speed = <9600>;
>>> device_type = "serial";
>>> interrupt-parent = <&opb_intc_0>;
>>> interrupts = < 1 0 >;
>>> port-number = <0>;
>>> reg = < 0x40600000 0x10000 >;
>>> xlnx,baudrate = <0x9600>;
>>> xlnx,clk-freq = <0x5f5e100>;
>>> xlnx,data-bits = <0x8>;
>>> xlnx,odd-parity = <0x0>;
>>> xlnx,use-parity = <0x0>;
>>> } ;
>>> SysACE_CompactFlash: sysace@41800000 {
>>> compatible = "xlnx,opb-sysace-1.00.c";
>>> interrupt-parent = <&opb_intc_0>;
>>> interrupts = < 0 2 >;
>>> reg = < 0x41800000 0x10000 >;
>>> xlnx,mem-width = <0x10>;
>>> } ;
>>> opb_intc_0: interrupt-controller@41200000 {
>>> #interrupt-cells = <0x2>;
>>> compatible = "xlnx,opb-intc-1.00.c";
>>> interrupt-controller ;
>>> reg = < 0x41200000 0x10000 >;
>>> xlnx,num-intr-inputs = <0x2>;
>>> } ;
>>> } ;
>>> } ;
>>> }  ;
>>>
>> ************************************************************************
>> *****************************
>>> *
>>>
>> ************************************************************************
>> *****************************
>>> *
>>>
>>> Then cp <linux_path>/arch/powerpc/configs/40x/virtex4_defconfig
>>> <linux_path>/.
>>>
>>> Then
>>> cd <linux_path>
>>> export ARCH=powerpc
>>> export CROSS_COMPILE=powerpc-405-linux-gnu-
>>> export
>>>
>> PATH=${PATH}:$HOME/xupv2p/opt/crosstool/gcc-3.4.5-glibc-2.3.5/powerpc-40
>> 5-linux-gnu/bin
>>> make menuconfig
>>> I disabled all the options and enabled only:
>>>
>> ------------------------------------------------------------------------
>> -----------------------------
>>> --------------------------------------------------------------------
>>> Processor support ->  Processor Type AMCC 40x (!!!  there is not ppc
>> 40x)
>>> Platform Support ->  Generic Xilinx Virtex board
>>> Kernel options ->   Kernel support for ELF binaries
>>>                             Math emulation
>>>                            Default bootloader kernel arguments
>>>                              (console=ttyS0,9600)    Initial kernel
>> command
>>> string
>>>                                      (simpleImage.virtex405-ml405)
>>> Additional default image types
>>> Device Drivers -> Character Devices -> Virtual Terminal
>>>                                                            Serial
>> Devices ->
>>> [*] 8250/16550 and compatible serial
>>>
>>> [*]   Console on 8250/16550 and compatible serial port
>>>
>>> (4) Maximum number of 8250/16550 serial ports
>>>
>>> (4) Number of 8250/16550 serial ports to register at runtime
>>>
>>>
>> ------------------------------------------------------------------------
>> -----------------------------
>>> ---------------------------------------------------------------
>>>
>>> Then make clean && make dep && make zImage
>>> I obtained a binary zImage file (and not zImage.elf) !!!! and I
>> obtained
>>> simpleImage.virtex405-ml405.elf in <linux_path>/arch/powerpc/boot .
>>>
>>> I used xmd to generated a system.ace from the bitstream and the elf.
>>> The report of xmd is:
>>>
>> ************************************************************************
>> ******
>>>
>> ************************************************************************
>> *****
>>> XMD% xmd -tcl genace.tcl -opt genace1.opt
>>> Xilinx Microprocessor Debug (XMD) Engine
>>> Xilinx EDK 8.2.02 Build EDK_Im_Sp2.4
>>> Copyright (c) 1995-2005 Xilinx, Inc.  All rights reserved.
>>> Executing user script : genace.tcl
>>>
>>>
>> #######################################################################
>>> XMD GenACE utility. Generate SystemACE File from bit/elf/data Files
>>>
>> #######################################################################
>>> Using GenACE option file : genace1.opt
>>> GenACE Options:
>>> Board      : xupv2p
>>> Jtag Devs  : xc2vp30
>>> FPGA pos   : 1
>>> JPROG      : true
>>> HW File    :
>>> /home/dhouib/xupv2p/edk_300_100_linux_2-6/implementation/system.bit
>>> ACE File   : system3.ace
>>> nCPUs      : 1
>>>
>>> Processor ppc_hw_1 Information
>>> Debug opt : -debugdevice devicenr 1 cpunr 1
>>> ELF files : simpleImage.virtex405-ml405-3.elf
>>> Start PC Address : 0x00400000
>>>
>>> ############################################################
>>> Converting Bitstream
>>> '/home/dhouib/xupv2p/edk_300_100_linux_2-6/implementation/system.bit'
>> to SVF
>>> file
>> '/home/dhouib/xupv2p/edk_300_100_linux_2-6/implementation/system.svf'
>>> Executing 'impact -batch bit2svf.scr'
>>>
>>> Copying
>> /home/dhouib/xupv2p/edk_300_100_linux_2-6/implementation/system.svf
>>> File to  system3.svf File
>>>
>>>
>>> ############################################################
>>> Converting ELF file 'simpleImage.virtex405-ml405-3.elf' to SVF file
>>> 'simpleImage.virtex405-ml405-3.svf'
>>> Target reset successfully
>>> section, .text: 0x00400000-0x00408ed4
>>> section, .data: 0x00409000-0x0040ac18
>>> section, __builtin_cmdline: 0x0040ac18-0x0040ae18
>>> section, .kernel:dtb: 0x0040ae18-0x0040be33
>>> section, .kernel:vmlinux.strip: 0x0040c000-0x004c3ae1
>>> section, .bss: 0x004c4000-0x004d0dd8
>>> Downloaded Program simpleImage.virtex405-ml405-3.elf
>>> Setting PC with program start addr = 0x00400000
>>> PC reset to 0x00400000, Clearing MSR Register
>>>
>>> Copying simpleImage.virtex405-ml405-3.svf File to  system3.svf File
>>>
>>>
>>> ############################################################
>>> Writing Processor JTAG "continue" command to SVF file 'sw_suffix.svf'
>>> PC reset to 0x00400000, Clearing MSR Register
>>> Processor started. Type "stop" to stop processor
>>>
>>> ############################################################
>>> Converting SVF file 'system3.svf' to SystemACE file 'system3.ace'
>>> Executing 'impact -batch svf2ace.scr'
>>>
>>> SystemACE file 'system3.ace' created successfully
>>>
>> ************************************************************************
>> ********************
>>>
>> ************************************************************************
>> ********************
>>>
>>>
>>> I copied the system3.ace (3 because it was the third kernel that I
>> tested
>>> :((( ) to the flash disk partition 1 (Type = FAT16, Size = 32Mo ).
>>> And I booted the kernel.
>>> I got fllowing message on the Terminal:
>>>
>>>
>> ************************************************************************
>> *****************
>>> zImage starting: loaded at 0x00400000 (sp: 0x004c4efc)
>>> Allocating 0x1acdec bytes for kernel ...
>>> gunzipping (0x00000000 <- 0x0040c000:0x004c3ae1)...done 0x1951b8 bytes
>>>
>>> Linux/PowerPC load: console=ttyS0,9600 root=/dev/xsysace/disc0/part3
>> ip=on
>>> Finalizing device tree... flat tree at 0x40ae18
>>>
>> ************************************************************************
>> *******************
>>>
>>> My Questions are:
>>> 1. Why he stops here?
>>> 2. Why I didn't obtained zImage.elf but
>> simpleImage.virtex405-ml405.elf
>>> 3. Do I have to copy other files from my <edk_project_path>
>> (xparameters.h ,
>>> drivers ) to the <linux_path> ? (I copied only the xilinx.dts file)
>>>
>>> Thanks
>>> saadia
>>>
>>>
>>>
>>>
>>>
>>> --
>>> View this message in context:
>> http://www.nabble.com/Linux-2.6-boot-failure-on-xup-virtex-II-ppc405-
>>> tp20252128p20252128.html
>>> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
>>>
>>> _______________________________________________
>>> Linuxppc-embedded mailing list
>>> Linuxppc-embedded@ozlabs.org
>>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
>>
>> This email and any attachments are intended for the sole use of the named
>> recipient(s) and contain(s) confidential information that may be
>> proprietary, privileged or copyrighted under applicable law. If you are
>> not the intended recipient, do not read, copy, or forward this email
>> message or any attachments. Delete this email message and any attachments
>> immediately.
>>
>>
>>
>>
>> ------------------------------
>>
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
>> End of Linuxppc-embedded Digest, Vol 50, Issue 47
>> *************************************************
>>
>
>
>
> ------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
> End of Linuxppc-embedded Digest, Vol 51, Issue 1
> ************************************************
> 
