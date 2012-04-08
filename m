Return-Path: <jerry_dw@126.com>
Received: from m15-55.126.com (m15-55.126.com [220.181.15.55])
 by ozlabs.org (Postfix) with ESMTP id CAABFB7001
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Apr 2012 22:56:51 +1000 (EST)
Date: Sun, 8 Apr 2012 20:56:45 +0800 (CST)
From: jerry_dw <jerry_dw@126.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Message-ID: <2bd5b078.15165.13692072e57.Coremail.jerry_dw@126.com>
Subject: kernel3.2.13 cannot boot on my mpc8260 board using u-boot2011.12
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_Part_226910_885657422.1333889805911"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

------=_Part_226910_885657422.1333889805911
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: 7bit

Hi:
    My board is a custom MPC8260 board, with 4MB flash,128MB SDRAM.
I modified pq2fads.dts and pq2fads_defconfig,
then compile the kernel.The kernel halt after displaying "Booting using OF flat tree.".
 
Serial Console:
U-Boot 2011.12 (Mar 30 2012 - 15:57:39)
MPC8260 Reset Status: External Soft, External Hard
MPC8260 Clock Configuration
 - Bus-to-Core Mult 4.5x, VCO Div 2, 60x Bus Freq  22-65 , Core Freq 100-300
 - dfbrg 1, corecnf 0x17, busdf 5, cpmdf 1, plldf 0, pllmf 2, pcidf 3
 - vco_out  399999996, scc_clk   99999999, brg_clk   24999999
 - cpu_clk  299999997, cpm_clk  199999998, bus_clk   66666666
CPU:   MPC8260 (HiP4 Rev 14, Mask B.1 4K25A) at 300 MHz
Board: SJ3208 TDM to EtherNet
SDRAM: 128 MiB
Top of RAM usable for U-Boot at: 08000000
Reserving 261k for U-Boot at: 07fbe000
Reserving 256k for malloc() at: 07f7e000
Reserving 76 Bytes for Board Info at: 07f7dfb4
Reserving 108 Bytes for Global Data at: 07f7df48
Stack Pointer at: 07f7df28
New Stack Pointer is: 07f7df28
Now running in RAM - U-Boot at: 07fbe000
FLASH: flash_protect ON: from 0x20000000 to 0x2003BFFF
protect on 0
protect on 1
protect on 2
protect on 3
protect on 4
protect on 5
protect on 6
protect on 7
protect on 8
flash_protect ON: from 0x20060000 to 0x2007FFFF
protect on 10
4 MiB
*** Warning - bad CRC, using default environment
Destroy Hash Table: 07ffcf04 table = (null)
Create Hash Table: N=91
INSERT: table 07ffcf04, filled 1/97 rv 07f7e148 ==> name="bootargs" value="console=ttyCPM0,9600 root=/dev/ram0"
INSERT: table 07ffcf04, filled 2/97 rv 07f7e2bc ==> name="bootcmd" value="bootm 0x20080000 0x20240000"
INSERT: table 07ffcf04, filled 3/97 rv 07f7e2ec ==> name="bootdelay" value="5"
INSERT: table 07ffcf04, filled 4/97 rv 07f7e19c ==> name="baudrate" value="9600"
INSERT: table 07ffcf04, filled 5/97 rv 07f7e574 ==> name="ethaddr" value="00:10:EC:D0:30:88"
INSERT: table 07ffcf04, filled 6/97 rv 07f7e178 ==> name="ipaddr" value="12.13.38.221"
INSERT: table 07ffcf04, filled 7/97 rv 07f7e550 ==> name="serverip" value="12.13.38.222"
INSERT: table 07ffcf04, filled 8/97 rv 07f7e4d8 ==> name="gatewayip" value="12.13.38.254"
INSERT: table 07ffcf04, filled 9/97 rv 07f7e34c ==> name="netmask" value="255.255.255.0"
INSERT: free(data = 07f7e008)
INSERT: done
In:    serial
Out:   serial
Err:   serial
U-Boot relocated to 07fbe000
Net:   FCC1
Reset Ethernet PHY
### main_loop entered: bootdelay=5
### main_loop: bootcmd="bootm 0x20080000 0x20240000"
Hit any key to stop autoboot:  0
=> bootm 0x20080000 0x20240000 0x203ff000
## Current stack ends at 0x07f7dd10
*  kernel: cmdline image address = 0x20080000
## Booting kernel from Legacy Image at 20080000 ...
   Image Name:   Linux-3.2.13.Jerry_Test_V1.1
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1527637 Bytes = 1.5 MiB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   kernel data at 0x20080040, len = 0x00174f55 (1527637)
*  ramdisk: cmdline image address = 0x20240000
## Loading init Ramdisk from Legacy Image at 20240000 ...
   Image Name:   SJ3208_Ramdisk_01
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    1730966 Bytes = 1.7 MiB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   ramdisk start = 0x20240040, ramdisk end = 0x203e69d6
*  fdt: cmdline image address = 0x203ff000
## Checking for 'FDT'/'FDT Image' at 203ff000
*  fdt: raw FDT blob
## Flattened Device Tree blob at 203ff000
   Booting using the fdt blob at 0x203ff000
   of_flat_tree at 0x203ff000 size 0x00000fbb
   Uncompressing Kernel Image ... OK
   kernel loaded at 0x00000000, end = 0x0030fda0
## initrd_high = 0xffffffff, copy_to_ram = 1
   Loading Ramdisk to 07dd6000, end 07f7c996 ... OK
   ramdisk load start = 0x07dd6000, ramdisk load end = 0x07f7c996
## device tree at 203ff000 ... 203fffba (len=16315 [0x3FBB])
   Loading Device Tree to 003fc000, end 003fffba ... OK
Updating property '/soc@f0000000/cpm@119c0/ethernet@11320/mac-address' =  00 10 ec d0 30 88
Updating property '/soc@f0000000/cpm@119c0/ethernet@11320/local-mac-address' =  00 10 ec d0 30 88
Updating property 'clock-frequency' =  01 7d 78 3f
Updating property 'bus-frequency' =  03 f9 40 aa
Updating property 'timebase-frequency' =  00 fe 50 2a
Updating property 'clock-frequency' =  11 e1 a2 fd
## Transferring control to Linux (at address 00000000) ...
   Booting using OF flat tree...

And Log_buf as follow:
20120331:log_buffer as follow
<6>Using Freescale PQ2FADS machine description.
<3>Cannot reserve gpages without hugetlb enabled.
<5>Linux version 3.2.13.Jerry_1.0_Test (jerry@jerry-desktop) (gcc version 4.2.2) #1 Fri Mar 30 1 1:07:35 CST 2012.
<4>Found initrd at 0xc7dd6000:0xc7f7c996.
<4>Machine check in kernel mode..
<4>Caused by (from SRR1=41030): Transfer error ack signal.
<4>Oops: Machine check, sig: 7 [#1].
<4>Freescale PQ2FADS.
<4>NIP: c00175c0 LR: c0328a9c CTR:00002710.
<4>REGS: c035bed0 TRAP 0200   Not tainted  (3.2.13.Jerry_1.0_Test).
<4>MSR: 00041030 <ME,IR,DR>  CR: 22022024  XER: 20000000.
<4>TASK =c0349478[0] 'swapper' THREAD: c035a000.
<4>GPR00: 00002710 c035bf80 c0349478 80010000 00000000 c037cefc f00095a90000a000 .
<4>GPR08: 00000008 fdfd19c0 00000000 c0360000 c036339c 02040000 00000000 00000000 .
<4>GPR16: 07ff0bac 07fe9728 00000000 00000000 00000000 00000000 00000000 00000000 .
<4>GPR24: 00000000 00000000 40000000 07ffcf88 c0360000 c03613ec  c035e020 00001032 .
<4>NIP [c00175c0] cpm_command+0x4c/0xb0.
<4>LR [c0328a9c] pq2fads_setup_arch+0x3c/0x260.
<4>Call Trace:.
<4>[c035bf80] [c03613ec] ppc_md+0x0/0xd8 (unreliable).
<4>[c035bf90] [c0328a9c] pq2fads_setup_arch+0x3c/0x260.
<4>[c035bfb0] [c0324e58] setup_arch+0x150/0x18c.
<4>[c035bfc0] [c0320864] start_kernel+0x84/0x2e0.
<4>[c035bff0] [00003438]  0x3438.
<4>Instruction dump:.
<4>3d60c036 64630001 7c632378 812b00f4 7c0004ac 90690000 38002710 7c0903a6 .
<4>48000008 4240003c 812b00f4 7c0004ac.<80090000> 0c000000 4c00012c 74090001 .
<4>---[end trace 31fd0ba7d8756001 ]---.
<0>Kernel panic - not syncing: Attempted to kill the idle task!.
<4>Call Trace:.
<4>[c035bdb0] [c0007f08] show_stack+0x4c/0x16c (unreliable).
<4>[c035bdf0] [c001e714] panic+0xa8/0x1f4.
<4>[c035be40] [c00227a8] do_exit+0x5a4/0x658.
<4>[c035be80] [c000ba98] kerne l_bad_stack+0x0/0x4c.
<4>[c035bea0] [c000bcc0] machine_check_exception+0xe4/0x170
<4>[c035bec0] [c000f334] ret_from_except_full+0x0/0x4c.
<4>--- Exception: 200 at cpm_command+0x4c/0xb0.
<4>    LR = pq2fads_setup_arch+0x3c/0x260
<4>[c035bf80] [c03613ec] ppc_md+0x0/0xd8 (unreliable).
<4>[c035bf90] [c0328a9c] pq2fads_setup_arch+0x3c/0x260.
<4>[c035bfb0] [c0324e58] setup_arch+0x150/0x18c.
<4>[c035bfc0] [c0320864] start_kernel+0x84/0x2e0.
<4>[c035bff0] [00003438] 0x3438.
<0>Rebooting in 180 seconds......
 
I have no idea about this,
u-boot,Flat device tree ,kernel,Ramdisk ,Thatwas wrong??

Best regards.
Jerry

------=_Part_226910_885657422.1333889805911
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: 7bit

<div style="line-height:1.7;color:#000000;font-size:14px;font-family:arial"><DIV>Hi:</DIV>
<DIV>&nbsp;&nbsp;&nbsp; My board is a custom MPC8260 board, with 4MB flash,128MB SDRAM.<BR>I modified pq2fads.dts and pq2fads_defconfig,</DIV>
<DIV>then compile the kernel.The kernel halt after displaying "Booting using OF flat tree.".</DIV>
<DIV>&nbsp;</DIV>
<DIV>Serial Console:</DIV>
<DIV>U-Boot 2011.12 (Mar 30 2012 - 15:57:39)</DIV>
<DIV>MPC8260 Reset Status: External Soft, External Hard</DIV>
<DIV>MPC8260 Clock Configuration<BR>&nbsp;- Bus-to-Core Mult 4.5x, VCO Div 2, 60x Bus Freq&nbsp; 22-65 , Core Freq 100-300<BR>&nbsp;- dfbrg 1, corecnf 0x17, busdf 5, cpmdf 1, plldf 0, pllmf 2, pcidf 3<BR>&nbsp;- vco_out&nbsp; 399999996, scc_clk&nbsp;&nbsp; 99999999, brg_clk&nbsp;&nbsp; 24999999<BR>&nbsp;- cpu_clk&nbsp; 299999997, cpm_clk&nbsp; 199999998, bus_clk&nbsp;&nbsp; 66666666</DIV>
<DIV>CPU:&nbsp;&nbsp; MPC8260 (HiP4 Rev 14, Mask B.1 4K25A) at 300 MHz<BR>Board: SJ3208 TDM to EtherNet <BR>SDRAM: 128 MiB<BR>Top of RAM usable for U-Boot at: 08000000<BR>Reserving 261k for U-Boot at: 07fbe000<BR>Reserving 256k for malloc() at: 07f7e000<BR>Reserving 76 Bytes for Board Info at: 07f7dfb4<BR>Reserving 108 Bytes for Global Data at: 07f7df48<BR>Stack Pointer at: 07f7df28<BR>New Stack Pointer is: 07f7df28<BR>Now running in RAM - U-Boot at: 07fbe000<BR>FLASH: flash_protect ON: from 0x20000000 to 0x2003BFFF<BR>protect on 0<BR>protect on 1<BR>protect on 2<BR>protect on 3<BR>protect on 4<BR>protect on 5<BR>protect on 6<BR>protect on 7<BR>protect on 8<BR>flash_protect ON: from 0x20060000 to 0x2007FFFF<BR>protect on 10<BR>4 MiB<BR>*** Warning - bad CRC, using default environment</DIV>
<DIV>Destroy Hash Table: 07ffcf04 table = (null)<BR>Create Hash Table: N=91<BR>INSERT: table 07ffcf04, filled 1/97 rv 07f7e148 ==&gt; name="bootargs" value="console=ttyCPM0,9600 root=/dev/ram0"<BR>INSERT: table 07ffcf04, filled 2/97 rv 07f7e2bc ==&gt; name="bootcmd" value="bootm 0x20080000 0x20240000"<BR>INSERT: table 07ffcf04, filled 3/97 rv 07f7e2ec ==&gt; name="bootdelay" value="5"<BR>INSERT: table 07ffcf04, filled 4/97 rv 07f7e19c ==&gt; name="baudrate" value="9600"<BR>INSERT: table 07ffcf04, filled 5/97 rv 07f7e574 ==&gt; name="ethaddr" value="00:10:EC:D0:30:88"<BR>INSERT: table 07ffcf04, filled 6/97 rv 07f7e178 ==&gt; name="ipaddr" value="12.13.38.221"<BR>INSERT: table 07ffcf04, filled 7/97 rv 07f7e550 ==&gt; name="serverip" value="12.13.38.222"<BR>INSERT: table 07ffcf04, filled 8/97 rv 07f7e4d8 ==&gt; name="gatewayip" value="12.13.38.254"<BR>INSERT: table 07ffcf04, filled 9/97 rv 07f7e34c ==&gt; name="netmask" value="255.255.255.0"<BR>INSERT: free(data = 07f7e008)<BR>INSERT: done<BR>In:&nbsp;&nbsp;&nbsp; serial<BR>Out:&nbsp;&nbsp; serial<BR>Err:&nbsp;&nbsp; serial<BR>U-Boot relocated to 07fbe000<BR>Net:&nbsp;&nbsp; FCC1<BR>Reset Ethernet PHY<BR>### main_loop entered: bootdelay=5</DIV>
<DIV>### main_loop: bootcmd="bootm 0x20080000 0x20240000"<BR>Hit any key to stop autoboot:&nbsp; 0 <BR>=&gt; bootm 0x20080000 0x20240000 0x203ff000<BR>## Current stack ends at 0x07f7dd10<BR>*&nbsp; kernel: cmdline image address = 0x20080000<BR>## Booting kernel from Legacy Image at 20080000 ...<BR>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-3.2.13.Jerry_Test_V1.1<BR>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip compressed)<BR>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1527637 Bytes = 1.5 MiB<BR>&nbsp;&nbsp; Load Address: 00000000<BR>&nbsp;&nbsp; Entry Point:&nbsp; 00000000<BR>&nbsp;&nbsp; Verifying Checksum ... OK<BR>&nbsp;&nbsp; kernel data at 0x20080040, len = 0x00174f55 (1527637)<BR>*&nbsp; ramdisk: cmdline image address = 0x20240000<BR>## Loading init Ramdisk from Legacy Image at 20240000 ...<BR>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; SJ3208_Ramdisk_01<BR>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux RAMDisk Image (gzip compressed)<BR>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1730966 Bytes = 1.7 MiB<BR>&nbsp;&nbsp; Load Address: 00000000<BR>&nbsp;&nbsp; Entry Point:&nbsp; 00000000<BR>&nbsp;&nbsp; Verifying Checksum ... OK<BR>&nbsp;&nbsp; ramdisk start = 0x20240040, ramdisk end = 0x203e69d6<BR>*&nbsp; fdt: cmdline image address = 0x203ff000<BR>## Checking for 'FDT'/'FDT Image' at 203ff000<BR>*&nbsp; fdt: raw FDT blob<BR>## Flattened Device Tree blob at 203ff000<BR>&nbsp;&nbsp; Booting using the fdt blob at 0x203ff000<BR>&nbsp;&nbsp; of_flat_tree at 0x203ff000 size 0x00000fbb<BR>&nbsp;&nbsp; Uncompressing Kernel Image ... OK<BR>&nbsp;&nbsp; kernel loaded at 0x00000000, end = 0x0030fda0<BR>## initrd_high = 0xffffffff, copy_to_ram = 1<BR>&nbsp;&nbsp; Loading Ramdisk to 07dd6000, end 07f7c996 ... OK<BR>&nbsp;&nbsp; ramdisk load start = 0x07dd6000, ramdisk load end = 0x07f7c996<BR>## device tree at 203ff000 ... 203fffba (len=16315 [0x3FBB])<BR>&nbsp;&nbsp; Loading Device Tree to 003fc000, end 003fffba ... OK<BR>Updating property <A href="mailto:'/soc@f0000000/cpm@119c0/ethernet@11320/mac-address'">'/soc@f0000000/cpm@119c0/ethernet@11320/mac-address'</A> =&nbsp; 00 10 ec d0 30 88<BR>Updating property <A href="mailto:'/soc@f0000000/cpm@119c0/ethernet@11320/local-mac-address'">'/soc@f0000000/cpm@119c0/ethernet@11320/local-mac-address'</A> =&nbsp; 00 10 ec d0 30 88<BR>Updating property 'clock-frequency' =&nbsp; 01 7d 78 3f<BR>Updating property 'bus-frequency' =&nbsp; 03 f9 40 aa<BR>Updating property 'timebase-frequency' =&nbsp; 00 fe 50 2a<BR>Updating property 'clock-frequency' =&nbsp; 11 e1 a2 fd<BR>## Transferring control to Linux (at address 00000000) ...<BR>&nbsp;&nbsp; Booting using OF flat tree...<BR></DIV>
<DIV>And Log_buf as follow:</DIV>
<DIV>20120331:log_buffer as follow <BR>&lt;6&gt;Using Freescale PQ2FADS machine description.<BR>&lt;3&gt;Cannot reserve gpages without hugetlb enabled.<BR>&lt;5&gt;Linux version 3.2.13.Jerry_1.0_Test (<A href="mailto:jerry@jerry-desktop">jerry@jerry-desktop</A>) (gcc version 4.2.2) #1 Fri Mar 30 1 1:07:35 CST 2012.<BR>&lt;4&gt;Found initrd at 0xc7dd6000:0xc7f7c996.<BR>&lt;4&gt;Machine check in kernel mode..<BR>&lt;4&gt;Caused by (from SRR1=41030): Transfer error ack signal.<BR>&lt;4&gt;Oops: Machine check, sig: 7 [#1].<BR>&lt;4&gt;Freescale PQ2FADS.<BR>&lt;4&gt;NIP: c00175c0 LR: c0328a9c CTR:00002710.<BR>&lt;4&gt;REGS: c035bed0 TRAP 0200&nbsp;&nbsp; Not tainted&nbsp; (3.2.13.Jerry_1.0_Test).<BR>&lt;4&gt;MSR: 00041030 &lt;ME,IR,DR&gt;&nbsp; CR: 22022024&nbsp; XER: 20000000.<BR>&lt;4&gt;TASK =c0349478[0] 'swapper' THREAD: c035a000.<BR>&lt;4&gt;GPR00: 00002710 c035bf80 c0349478 80010000 00000000 c037cefc f00095a90000a000 .<BR>&lt;4&gt;GPR08: 00000008 fdfd19c0 00000000 c0360000 c036339c 02040000 00000000 00000000 .<BR>&lt;4&gt;GPR16: 07ff0bac 07fe9728 00000000 00000000 00000000 00000000 00000000 00000000 .<BR>&lt;4&gt;GPR24: 00000000 00000000 40000000 07ffcf88 c0360000 c03613ec&nbsp; c035e020 00001032 .<BR>&lt;4&gt;NIP [c00175c0] cpm_command+0x4c/0xb0.<BR>&lt;4&gt;LR [c0328a9c] pq2fads_setup_arch+0x3c/0x260.<BR>&lt;4&gt;Call Trace:.<BR>&lt;4&gt;[c035bf80] [c03613ec] ppc_md+0x0/0xd8 (unreliable).<BR>&lt;4&gt;[c035bf90] [c0328a9c] pq2fads_setup_arch+0x3c/0x260.<BR>&lt;4&gt;[c035bfb0] [c0324e58] setup_arch+0x150/0x18c.<BR>&lt;4&gt;[c035bfc0] [c0320864] start_kernel+0x84/0x2e0.<BR>&lt;4&gt;[c035bff0] [00003438]&nbsp; 0x3438.<BR>&lt;4&gt;Instruction dump:.<BR>&lt;4&gt;3d60c036 64630001 7c632378 812b00f4 7c0004ac 90690000 38002710 7c0903a6 .<BR>&lt;4&gt;48000008 4240003c 812b00f4 7c0004ac.&lt;80090000&gt; 0c000000 4c00012c 74090001 .<BR>&lt;4&gt;---[end trace 31fd0ba7d8756001 ]---.<BR>&lt;0&gt;Kernel panic - not syncing: Attempted to kill the idle task!.<BR>&lt;4&gt;Call Trace:.<BR>&lt;4&gt;[c035bdb0] [c0007f08] show_stack+0x4c/0x16c (unreliable).<BR>&lt;4&gt;[c035bdf0] [c001e714] panic+0xa8/0x1f4.<BR>&lt;4&gt;[c035be40] [c00227a8] do_exit+0x5a4/0x658.<BR>&lt;4&gt;[c035be80] [c000ba98] kerne l_bad_stack+0x0/0x4c.<BR>&lt;4&gt;[c035bea0] [c000bcc0] machine_check_exception+0xe4/0x170<BR>&lt;4&gt;[c035bec0] [c000f334] ret_from_except_full+0x0/0x4c.<BR>&lt;4&gt;--- Exception: 200 at cpm_command+0x4c/0xb0.<BR>&lt;4&gt;&nbsp;&nbsp;&nbsp; LR = pq2fads_setup_arch+0x3c/0x260<BR>&lt;4&gt;[c035bf80] [c03613ec] ppc_md+0x0/0xd8 (unreliable).<BR>&lt;4&gt;[c035bf90] [c0328a9c] pq2fads_setup_arch+0x3c/0x260.<BR>&lt;4&gt;[c035bfb0] [c0324e58] setup_arch+0x150/0x18c.<BR>&lt;4&gt;[c035bfc0] [c0320864] start_kernel+0x84/0x2e0.<BR>&lt;4&gt;[c035bff0] [00003438] 0x3438.<BR>&lt;0&gt;Rebooting in 180 seconds......</DIV>
<DIV>&nbsp;</DIV>
<DIV>I have no idea about this,<BR>u-boot,Flat device tree ,kernel,Ramdisk&nbsp;,<SPAN closure_uid_zdss5b="175" Pc="null">That</SPAN> <SPAN class="hps" closure_uid_zdss5b="176" Pc="null">was wrong</SPAN><SPAN closure_uid_zdss5b="177" Pc="null">?</SPAN>? <BR><BR>Best regards.<BR>Jerry<BR></DIV></div><br><br><span title="neteasefooter"><span id="netease_mail_footer"></span></span>
------=_Part_226910_885657422.1333889805911--
