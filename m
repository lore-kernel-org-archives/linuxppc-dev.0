Return-Path: <andy.gotz@esrf.fr>
Received: from out.esrf.fr (firewall.esrf.fr [193.49.43.1])
	by ozlabs.org (Postfix) with ESMTP id 6F2F667BC5
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Nov 2006 11:51:44 +1100 (EST)
Subject: Re: Memec v4fx12lc - problem booting linux on ppc
Message-ID: <45675884.80108@esrf.fr>
Date: Fri, 24 Nov 2006 21:39:32 +0100
From: Andy Gotz <andy.gotz@esrf.fr>
MIME-Version: 1.0
To: Olivier GOUDARD <olivier.goudard@esrf.fr>
References: <1164022946.8340.6.camel@l-cb312-1.esrf.fr>
	<JG200611211159003.3859000@co-nss.co.jp>
	<1164102298.21858.4.camel@l-cb312-1.esrf.fr>
	<4562E546.9070401@ru.mvista.com>
	<7.0.1.0.1.20061121153812.0430db90@esrf.fr>
	<45632A8E.3010509@ru.mvista.com>
	<7.0.1.0.1.20061124164552.01f06298@esrf.fr>
In-Reply-To: <7.0.1.0.1.20061124164552.01f06298@esrf.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andrei Konovalov <akonovalov@ru.mvista.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,

yes , as Olivier says we are highly motivated and have a feeling we are 
close to our goal.

Here is the output from the boot just in case someone recognises our error :

loaded at:     00400000 004B61E4
board data at: 004B313C 004B3154
relocated to:  0040564C 00405664
zimage at:     00405C17 004B20B5
avail ram:     004B7000 04000000

Linux/PPC load: console=ttyS0,9600 ip=on
nfsroot=192.168.219.54:/root/myDesign/rootfs rw
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.4.20_mvl31-2vp7fg456_rev4 (root@l-cb312-1) (gcc version
3.3.1 (MontaVista 3.3.1-3.0.10.0300532 2003-12-24)) #16 Fri Nov 24
15:6Memec Virtex-II Pro Development Board
Port (C) 2002-2004 MontaVista Software, Inc. (source@mvista.com)
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,9600 ip=on
nfsroot=192.168.219.54:/root/myDesign/rootfs rw
Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFE000
hr_time_init: arch_to_nsec = 20971520, nsec_to_arch = 429496729
Calibrating delay loop... 99.73 BogoMIPS
Memory: 63072k available (1228k kernel code, 400k data, 60k init, 0k
highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
OCP uart ver 1.6.2 init complete
LSP Revision 28
ikconfig 0.5 with /proc/ikconfig
Starting kswapd
Disabling the Out Of Memory Killer
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs:s boot_options: 1
JFFS version 1.0, (C) 1999, 2000  Axis Communications AB
JFFS2 version 2.1. (C) 2001, 2002 Red Hat, Inc., designed by Axis
Communications AB.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with no serial options enabled
ttyS00 at 0xfdfff003 (irq = 26) is a 16450
xgpio #0 at 0x40000000 mapped to 0xC507D000
xgpio #1 at 0x40020000 mapped to 0xC508E000
xgpio #2 at 0x40040000 mapped to 0xC509F000
xgpio #3 at 0xC00BCA10 mapped to 0xC50B0A10
xilinx_char_lcd at 0xFE804800 (256 bytes) mapped to 0xC50C2800
Data machine check in kernel mode.
Oops: machine check, sig: 7
NIP: C00BC860 XER: 00000040 LR: C00BC8F4 SP: C02DDF60 REGS: c02ddeb0
TRAP: 0200    Not tainted
MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c02dc000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: C00BC8F4 C02DDF60 C02DC000 00000038 00001030 00000001 000007C7
C0160A9F
GPR08: 00000000 C50C2800 00000036 C0180000 C0180000 FFFFFBFF FFFFFFFF
FFFFFFFF
GPR16: C001658F 00400000 004B0000 004B3000 44000044 004B0000 004B3000
004B0000
GPR24: 00000000 00400000 00400000 6F6F7466 00000000 C0180000 C0178A44
C0178A04
Call backtrace:
00400000 C00BC8F4 C00BCBE8 C016A634 C000244C C0006E7C
Kernel panic: Attempted to kill init!
 <0>Rebooting in 180 seconds..<NULL>

Thanks again everyone for their help in getting us so far. The 2 
important things were Andrei's patch which proved to be indispensable 
and the others who directed us to the xparameters_<something>.h files 
with the hardware addresses.

For some strange reason XPS was updating the xparameters_ml300.h file 
with the correct addresses but not the xparameters_2vxp.h file. We 
copied the <xp>_ml300.h file to the <xp>_2vxp.h file and had to edit two 
variables which were referring to 32MB flash (we replaced them with the 
16MB addresses ?!). Then things started looking up. Has anyone an 
explanation for this confusion in .h files ?

Thanks

Andy

 Olivier GOUDARD wrote:
> Dear Andrei,
>
> Thanks to your advices we managed to view characters on the serial line.
> (I remind that we are trying to boot linux MontaVista 3.1 on V4FX12LC 
> board of Memec.)
> It looks like we where using the wrong xparameters_2vpx.h file.
>
> We also applyied your patch in arch/ppc/boot/simple/head.S
>
> After modifications we obtained :
> ______________________________________________________________________________ 
>
> loaded at:     00400000 004B61E4
> board data at: 004B313C 004B3154
> relocated to:  0040564C 00405664
> zimage at:     00405C17 004B20B5
> avail ram:     004B7000 04000000
>
> Linux/PPC load: console=ttyS0,9600 ip=on 
> nfsroot=192.168.219.54:/root/myDesign/rootfs rw
> Uncompressing Linux...done.
> Now booting the kernel
> .
> _______________________________________________________________________________ 
>
>
> Which is remotivating us a lot !!
> I also managed to get a longer boot, but I encounter a kernel panic 
> during the serial driver configuration...
>
> We are wondering what to do now ?
> Maybe we should try to find in xps why we are not using the right 
> xparameterXX.h file and generate a new bit file ?
> Or maybe we should concentrate our efforts on Linux configuration ?
>
> Any comments are welcome that might help us in the ppc/linux boot quest !
> Thanks again Andrei,
> Olivier
>
>
>
>
> At 17:34 21/11/2006, Andrei Konovalov wrote:
>> Olivier GOUDARD wrote:
>> > Dear Andrei,
>> >
>> > Thanks for all details provided in your mail. It looks like we have a
>> > lot to understand about the boot sequence.
>> > To answer your questions :
>> >
>> > We created our own platform with xps.
>>
>> I meant a new board entry in the kernel configuration.
>> Now I see - you are reusing the one for memec 2VPx.
>>
>> > We went throught the differents steps of the xps wizard to impelment
>> > ppc, UART, EMAC, SDRAM and so on.
>> > Then, we generated the Linux Support Package and compiled the 
>> Montavista
>> > previewkit
>> >  with the generated files in linux/arch and linux/drivers  from the
>> > Linux Support Package.
>> >
>> > The montavista previewkit used is :
>> > insight_memec-2vp7fg456_rev4-previewkit-ppc_405
>> >
>> > and this previewkit seems to be based on linux 2.4.20 version.
>>
>> Pro 3.1 preview kit is rather old, and does not have a workaround
>> required for Virtex4. This should not be a problem in your case though,
>> as I believe the generated files in linux/arch should have it.
>> Something like this hack:
>>
>> ---8<--------------------------------------------------------------
>> --- arch/ppc/boot/simple/head.S 4 Jan 2005 06:18:47 -0000       1.1
>> +++ arch/ppc/boot/simple/head.S 23 Jun 2005 05:11:42 -0000      1.2
>> @@ -46,6 +46,11 @@
>>   #endif
>>
>>   start_:
>> +       /* PPC errata 213: only for Virtex-4 */
>> +       mfccr0  0
>> +       oris    0,0,0x50000000@h
>> +       mtccr0  0
>> +
>>   #if defined(CONFIG_FORCE) || defined(CONFIG_PPMC260)
>>          /* We have some really bad firmware.  We must disable the L1
>>           * icache/dcache now or the board won't boot.
>> ---8<--------------------------------------------------------------
>>
>> There should be #ifdef CONFIG_XILINX_VIRTEX_4_FX here or like that,
>> but the kernel tree you are using doesn't have Virtex4 config option
>> (unlike e.g. community 2.6 tree or Montavista Pro 4.0)
>>
>> > I'm not sure that we used propers xparameters<something_else>.h file
>> > because I don't understand what you mean. I searched in my kernel
>> > sources to find xparam* but I was not successful.
>> > Can you enlighten my ignorance ?
>>
>> arch/ppc/platforms/xilinx_ocp/xparameters_2vpx.h
>>
>> The memec board uses this one (to find the addresses and the interrupt
>> numbers). Make sure the defines there match your bitstream.
>>
>> > I will check my UART configuration which seems to be very wrong ! :-)
>>
>> Your UART is 16x50, not UART Lite, correct?
>
> ____________________________________________________
> Olivier GOUDARD,
> European Synchrotron Radiation Facility
> Machine Division - Power Supply Group
> BP 220, F-38043 Grenoble Cedex, France
>
> Tel : +33 (0)4 76 88 24 69,   Fax : +33 (0)4 76 88 20 54
> ____________________________________________________ 
