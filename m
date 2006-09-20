Return-Path: <peterarbejde@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.204])
	by ozlabs.org (Postfix) with ESMTP id AB3D567A2E
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 19:16:56 +1000 (EST)
Received: by nz-out-0102.google.com with SMTP id i1so57611nzh
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 02:16:53 -0700 (PDT)
Message-ID: <36468a5c0609200216n753d69b0hdf8ff2cb53714f90@mail.gmail.com>
Date: Wed, 20 Sep 2006 11:16:53 +0200
From: "Peter N. Andreasen" <peterarbejde@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Linux on custom Xilinx board with PPC405 hangs on boot
In-Reply-To: <36468a5c0609140713pb42f3f8n3578151b50a488f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_260123_24536547.1158743813308"
References: <36468a5c0609120706i6c7e32efke7d8901d9ce4ae9b@mail.gmail.com>
	<4506D7DE.9070800@ru.mvista.com>
	<36468a5c0609140713pb42f3f8n3578151b50a488f@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_260123_24536547.1158743813308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have a custom Xilinx FPGA board which is similar to ML300 but uses
Uartllite and does not have disk or display.
When I start the Linux kernel I end up with an exception during the probe
for Flash - I think.
I have added a bunch of printk lines in order to see what is happening but I
am a little stuck at the moment.
The Flash chip is an AM29LV320D 4Mbyte in 16-bit access mode, and it sits on
address 0xFF80'0000
This is what I get on my terminal. I would be happy to hear your advice.
Peter



loaded at:     00400000 004CF1E0
board data at: 004CC138 004CC150
relocated to:  004052F4 0040530C
zimage at:     00405801 00472CFB
initrd at:     00473000 004CB2FF
avail ram:     004D0000 02000000

Linux/PPC load: root=/dev/ram rw console=ttl0
Uncompressing Linux...done.
Now booting the kernel

id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:mapin_ram done
MMU:setio
MMU:exit

Linux version 2.4.26 (pna@glazedevel) (gcc version 3.4.1) #50 Wed Sep 20
11:06:12 CEST 2006
setup_arch: enter
setup_arch: bootmem
Xilinx Virtex-II Pro port (C) 2002 MontaVista Software, Inc. (
source@mvista.com)
arch: exit
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram rw console=ttl0
(start) init/main.c: parse_options
(end) parse_options
(start) arch/ppc/mm/pgtable.c: __ioremap
(end) arch/ppc/mm/pgtable.c: __ioremap
Xilinx INTC #0 at 0x81200000 mapped to 0xFDFFF000
(start) arch/ppc/mm/pgtable.c: __ioremap
(end) arch/ppc/mm/pgtable.c: __ioremap
Calibrating delay loop... 287.53 BogoMIPS
Memory: 30924k available (776k kernel code, 276k data, 44k init, 0k highmem)
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
(start) init/main.c: init
(start) init/main.c: do_basic_setup

Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
(start) init/main.c: do_initcalls
Starting kswapd
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
JFFS version 1.0, (C) 1999, 2000  Axis Communications AB
JFFS2 version 2.1. (C) 2001 Red Hat, Inc., designed by Axis Communications
AB.
Generic RTC Driver v1.07
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
(start) drivers/mtd/maps/physmap.c: init_physmap
physmap flash device: 4000000 at ff800000
(start) arch/ppc/mm/pgtable.c: __ioremap
(end) arch/ppc/mm/pgtable.c: __ioremap
(start) drivers/mtd/chips/chipreg.c: do_map_probe
(start) drivers/mtd/chips/chipreg.c: get_mtd_chip_driver
(end) drivers/mtd/chips/chipreg.c: get_mtd_chip_driver
(after get_mtd_chip_driver) drivers/mtd/chips/chipreg.c: do_map_probe
(start) drivers/mtd/chips/gen_probe.c: mtd_do_chip_probe
(start) drivers/mtd/chips/gen_probe.c: genprobe_ident_chips
Instruction machine check in kernel mode.
Oops: machine check, sig: 7
NIP: C00A2960 XER: 40000000 LR: C009CBD8 SP: C04D9D90 REGS: c04d9ce0 TRAP:
0200    Not tainted
MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c04d8000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: C00A2958 C04D9D90 C04D8000 C00DC1C8 000000F0 00400000 C04D9DD0
C00DB387
GPR08: 00000002 C307D000 C0176360 00000001 C00F0000 000057E0 80001040
80000820
GPR16: 00001020 00000840 10021000 08040800 C00D0000 C00EAC18 C00D0000
00000000
GPR24: C00C0000 00000001 C04D9DD0 C04D9E10 C04D9E10 00400000 C04D9DD0
C00DC1C8
Call backtrace:
C009CE80 C00A26D0 C009D3A0 C009C750 C00E9BB0 C00024F4 C0005ED4
Kernel panic: Attempted to kill init!
 <0>Rebooting in 180 seconds..

------=_Part_260123_24536547.1158743813308
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have a custom Xilinx FPGA board which is similar to ML300 but uses Uartllite and does not have disk or display.<br>When I start the Linux kernel I end up with an exception during the probe for Flash - I think. <br>I have added a bunch of printk lines in order to see what is happening but I am a little stuck at the moment. 
<br>The Flash chip is an AM29LV320D 4Mbyte in 16-bit access mode, and it sits on address 0xFF80'0000<br>This is what I get on my terminal. I would be happy to hear your advice.<br>Peter<br><br><br><br>loaded at:&nbsp;&nbsp;&nbsp;&nbsp; 00400000 004CF1E0
<br>board data at: 004CC138 004CC150<br>relocated to:&nbsp; 004052F4 0040530C<br>zimage at:&nbsp;&nbsp;&nbsp;&nbsp; 00405801 00472CFB<br>initrd at:&nbsp;&nbsp;&nbsp;&nbsp; 00473000 004CB2FF<br>avail ram:&nbsp;&nbsp;&nbsp;&nbsp; 004D0000 02000000<br><br>Linux/PPC load: root=/dev/ram rw console=ttl0
<br>Uncompressing Linux...done.<br>Now booting the kernel<br><br>id mach(): done<br>MMU:enter<br>MMU:hw init<br>MMU:mapin<br>MMU:mapin_ram done<br>MMU:setio<br>MMU:exit<br><br>Linux version 2.4.26 (pna@glazedevel) (gcc version 
3.4.1) #50 Wed Sep 20 11:06:12 CEST 2006<br>setup_arch: enter<br>setup_arch: bootmem<br>Xilinx Virtex-II Pro port (C) 2002 MontaVista Software, Inc. (<a href="mailto:source@mvista.com">source@mvista.com</a>)<br>arch: exit
<br>On node 0 totalpages: 8192<br>zone(0): 8192 pages.<br>zone(1): 0 pages.<br>zone(2): 0 pages.<br>Kernel command line: root=/dev/ram rw console=ttl0<br>(start) init/main.c: parse_options<br>(end) parse_options<br>(start) arch/ppc/mm/pgtable.c: __ioremap
<br>(end) arch/ppc/mm/pgtable.c: __ioremap<br>Xilinx INTC #0 at 0x81200000 mapped to 0xFDFFF000<br>(start) arch/ppc/mm/pgtable.c: __ioremap<br>(end) arch/ppc/mm/pgtable.c: __ioremap<br>Calibrating delay loop... 287.53 BogoMIPS
<br>Memory: 30924k available (776k kernel code, 276k data, 44k init, 0k highmem)<br>Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)<br>Inode cache hash table entries: 2048 (order: 2, 16384 bytes)<br>Mount cache hash table entries: 512 (order: 0, 4096 bytes)
<br>Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)<br>Page-cache hash table entries: 8192 (order: 3, 32768 bytes)<br>POSIX conformance testing by UNIFIX<br>(start) init/main.c: init<br>(start) init/main.c: do_basic_setup
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>Linux NET4.0 for Linux 2.4<br>Based upon Swansea University Computer Society NET3.039<br>Initializing RT netlink socket<br>(start) init/main.c: do_initcalls<br>Starting kswapd<br>devfs: v1.12c (20020818) Richard Gooch (
<a href="mailto:rgooch@atnf.csiro.au">rgooch@atnf.csiro.au</a>)<br>devfs: boot_options: 0x1<br>JFFS version 1.0, (C) 1999, 2000&nbsp; Axis Communications AB<br>JFFS2 version 2.1. (C) 2001 Red Hat, Inc., designed by Axis Communications AB.
<br>Generic RTC Driver v1.07<br>RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize<br>loop: loaded (max 8 devices)<br>(start) drivers/mtd/maps/physmap.c: init_physmap<br>physmap flash device: 4000000 at ff800000
<br>(start) arch/ppc/mm/pgtable.c: __ioremap<br>(end) arch/ppc/mm/pgtable.c: __ioremap<br>(start) drivers/mtd/chips/chipreg.c: do_map_probe<br>(start) drivers/mtd/chips/chipreg.c: get_mtd_chip_driver<br>(end) drivers/mtd/chips/chipreg.c: get_mtd_chip_driver
<br>(after get_mtd_chip_driver) drivers/mtd/chips/chipreg.c: do_map_probe<br>(start) drivers/mtd/chips/gen_probe.c: mtd_do_chip_probe<br>(start) drivers/mtd/chips/gen_probe.c: genprobe_ident_chips<br>Instruction machine check in kernel mode.
<br>Oops: machine check, sig: 7<br>NIP: C00A2960 XER: 40000000 LR: C009CBD8 SP: C04D9D90 REGS: c04d9ce0 TRAP: 0200&nbsp;&nbsp;&nbsp; Not tainted<br>MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11<br>TASK = c04d8000[1] 'swapper' Last syscall: 120 
<br>last math 00000000 last altivec 00000000<br>GPR00: C00A2958 C04D9D90 C04D8000 C00DC1C8 000000F0 00400000 C04D9DD0 C00DB387 <br>GPR08: 00000002 C307D000 C0176360 00000001 C00F0000 000057E0 80001040 80000820 <br>GPR16: 00001020 00000840 10021000 08040800 C00D0000 C00EAC18 C00D0000 00000000 
<br>GPR24: C00C0000 00000001 C04D9DD0 C04D9E10 C04D9E10 00400000 C04D9DD0 C00DC1C8 <br>Call backtrace: <br>C009CE80 C00A26D0 C009D3A0 C009C750 C00E9BB0 C00024F4 C0005ED4 <br>Kernel panic: Attempted to kill init!<br>&nbsp;&lt;0&gt;Rebooting in 180 seconds..
<br><br>

------=_Part_260123_24536547.1158743813308--
