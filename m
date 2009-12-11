Return-Path: <ajijuni@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4B22939B.7060101@freescale.com>
References: <7675847.584551260168085277.JavaMail.nabble@isper.nabble.com>
	<20091207180719.GB8914@loki.buserror.net>
	<72d214170912101634l1fab97fewc849a819f767415c@mail.gmail.com>
	<4B22939B.7060101@freescale.com>
Date: Fri, 11 Dec 2009 11:39:48 -0800
Message-ID: <72d214170912111139w665b371aw1816ff571e4c0478@mail.gmail.com>
Subject: Re: dts file for MPC8343EA
From: Junita Ajith <ajijuni@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: multipart/alternative; boundary=00504502bc3430705a047a79162d
Cc: Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--00504502bc3430705a047a79162d
Content-Type: text/plain; charset=ISO-8859-1

Hi Scott:

After enabling debugging option from kernel (2.6.29) , here is the log.

We do have an external debugger(BDI). But soon after the crash happens,
looks like the core freezes and hence reading from any location in memeory
gives "SAP: Read access failed" error.

I have disabled PCI.

--Thanks,
Junita

Screen-dump :
===========
Bytes transferred = 12288 (3000 hex)
SC3000> bootm 0x00600000 - 0x00900000
## Booting image at 00600000 ...
   Image Name:   Linux-2.6.29
   Created:      2009-12-11   2:59:37 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    2177151 Bytes =  2.1 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
   Booting using the fdt at 0x900000
   Loading Device Tree to 007fc000, end 007fefff ... OK
Using MPC834x ITX machine description
Linux version 2.6.29 (root@localhost.localdomain) (gcc version 4.1.2) #1 Thu
De9console [udbg0] enabled
setup_arch: bootmem
mpc834x_itx_setup_arch()
Found FSL PCI host bridge at 0x00000000e0008600. Firmware bus number: 1->1
PCI host bridge /pci@e0008600  ranges:
 MEM 0x00000000a0000000..0x00000000afffffff -> 0x00000000a0000000 Prefetch
 MEM 0x00000000b0000000..0x00000000bfffffff -> 0x00000000b0000000
  IO 0x00000000e3000000..0x00000000e3ffffff -> 0x0000000000000000
arch: exit
Zone PFN ranges:
  DMA      0x00000000 -> 0x00008000
  Normal   0x00008000 -> 0x00008000
  HighMem  0x00008000 -> 0x00008000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00008000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
Kernel command line: root=/dev/ram rw console=ttyS0,115200 mem=128M
IPIC (128 IRQ sources) at fe7fc700
BUG: spinlock bad magic on CPU#0, swapper/0
 lock: c041c3b8, .magic: dead4ead, .owner: <none>/-1, .owner_cpu: -1
Call Trace:
[c0449db0] [c0008990] show_stack+0x3c/0x160 (unreliable)
[c0449de0] [c01fced8] spin_bug+0x8c/0xd0
[c0449e00] [c01fd0e0] _raw_spin_lock+0x94/0x16c
[c0449e30] [c02bcef0] _spin_lock_irqsave+0x20/0x38
[c0449e50] [c004ea4c] down_trylock+0x18/0x4c
[c0449e60] [c0032650] try_acquire_console_sem+0x20/0x7c
[c0449e70] [c0032de0] vprintk+0x148/0x3a4
[c0449f20] [c003308c] printk+0x50/0x60
[c0449f60] [c03f4e98] ipic_init+0x17c/0x180
[c0449fa0] [c03fa7dc] mpc834x_itx_init_IRQ+0x2c/0x40
[c0449fb0] [c03ebee8] init_IRQ+0x24/0x34
[c0449fc0] [c03e570c] start_kernel+0x158/0x2b4
[c0449ff0] [00003438] 0x3438
PID hash table entries: 512 (order: 9, 2048 bytes)
time_init: decrementer frequency = 66.666666 MHz
time_init: processor frequency   = 399.999996 MHz
clocksource: timebase mult[3c00001] shift[22] registered
clockevent: decrementer mult[1111] shift[16] cpu[0]
Console: colour dummy device 80x25
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
High memory: 0k
Memory: 124912k/131072k available (4188k kernel code, 6008k reserved, 192k
data)SLUB: Genslabs=12, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Calibrating delay loop... 133.12 BogoMIPS (lpj=266240)
Mount-cache hash table entries: 512
khelper used greatest stack depth: 7656 bytes left
         Unable to handle kernel paging request for data at address
0xffff3f60
Faulting instruction address: 0xc005e984
Oops: Kernel access of bad area, sig: 11 [#1]
MPC834x ITX
NIP: c005e984 LR: c005eae8 CTR: c005eb48
REGS: c781dd00 TRAP: 0300   Not tainted  (2.6.29)
MSR: 00009032 <EE,ME,IR,DR>  CR: 22000088  XER: 00000000
DAR: ffff3f60, DSISR: 20000000
TASK = c7818000[1] 'swapper' THREAD: c781c000
GPR00: c005eae8 c781ddb0 c7818000 ffff3f60 c03c1300 fffedb2b 00000100
00000000
GPR08: c0427c84 ffff3f60 00000001 c0440000 42000084 ffffffff 0fff7000
00800000
GPR16: ffffffff 00000000 007fff00 00000000 00000001 c0470000 c0478d1c
c03a0000
GPR24: 00000001 c0470000 0000000a c781c000 00009032 00000000 c0478ce0
c0427c64
NIP [c005e984] __rcu_process_callbacks+0x12c/0x2f0
LR [c005eae8] __rcu_process_callbacks+0x290/0x2f0
Call Trace:
[c781ddb0] [c005eae8] __rcu_process_callbacks+0x290/0x2f0 (unreliable)
[c781ddd0] [c005eb68] rcu_process_callbacks+0x20/0x44
[c781dde0] [c0038244] __do_softirq+0x90/0x140
[c781de20] [c0006534] do_softirq+0x58/0x5c
[c781de30] [c00380a0] irq_exit+0x48/0x58
[c781de40] [c0010e64] timer_interrupt+0x12c/0x188
[c781de60] [c0014484] ret_from_except+0x0/0x14
--- Exception: 901 at udbg_550_putc+0x1c/0x58
    LR = udbg_puts+0x48/0x6c
[c781df20] [00000000] (null) (unreliable)
[c781df30] [c03ee80c] udbg_progress+0x14/0x30
[c781df40] [c03ee8f8] ppc_init+0x3c/0x68
[c781df50] [c0003884] do_one_initcall+0x34/0x1a8
[c781dfd0] [c03e516c] kernel_init+0x94/0xf8
[c781dff0] [c0013c10] kernel_thread+0x4c/0x68
Instruction dump:
39200000 901e0008 913e0004 801f0000 901e0000 807e0024 2f830000 419e0090
7c691b78 3ba00000 48000008 41920038 <83e90000> 2e1f0000 41920008 7c00fa2c
Kernel panic - not syncing: Fatal exception in interrupt





On 12/11/09, Scott Wood <scottwood@freescale.com> wrote:
>
> Junita Ajith wrote:
>
>> Hi Scott:
>>
>> I am still stuck at Linux kernel booting in MPC8343EA based board.
>>
>> I have disabled "Ethernet, PCI, USB, dma engines " in the *.dts file and
>> also in the kernel config.
>> I am using MPC8349emitxgp.dts  ; enabled MPC8349ITX support in kernel
>> config also. In fact, I tried building MPC8349emITX; MPC8349MDS also. Same
>> behaviour!
>>
>> With this, the kernel boots up (explicitly passing the DTB file and
>> cuImage NEVER worked) and hangs after
>>
>> I am using Linux-V-2.6.27.18 and using powerpc-e300c3-gnu  toolchain  -
>> gcc-4.1.69-eglibc-2.5.69-1 to build u-boot-1.3.2 & linux.
>>
>> With this, the kernel boots up (explicitly passing the DTB file and
>> cuImage NEVER worked) and hangs after printing
>> "Calibrating delay loop... 133.12 BogoMIPS (lpj=266240)"
>>
>> With a few debug printks looks like the kernel hangs in
>> "cpu_idle" in --main/init.c
>>
>
> Try to find out what threads are blocked where.
>
> There may also have been a problem transitioning to the normal serial
> driver.  Do you have an external debugger than can extract the log buffer?
>
> -Scott
>

--00504502bc3430705a047a79162d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Scott:<br>
<br>
After enabling debugging option from kernel (2.6.29) , here is the log.<br>
<br>
We do have an external debugger(BDI). But soon after the crash happens,
looks like the core freezes and hence reading from any location in
memeory gives &quot;SAP: Read access failed&quot; error.<br>
<br>
I have disabled PCI. <br>
<br>
--Thanks,<br>
Junita<br>
<br>
Screen-dump :<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
Bytes transferred =3D 12288 (3000 hex)<br>
SC3000&gt; bootm 0x00600000 - 0x00900000<br>
## Booting image at 00600000 ...<br>
=A0=A0 Image Name:=A0=A0 Linux-2.6.29<br>
=A0=A0 Created:=A0=A0=A0=A0=A0 2009-12-11=A0=A0 2:59:37 UTC<br>
=A0=A0 Image Type:=A0=A0 PowerPC Linux Kernel Image (gzip compressed)<br>
=A0=A0 Data Size:=A0=A0=A0 2177151 Bytes =3D=A0 2.1 MB<br>
=A0=A0 Load Address: 00000000<br>
=A0=A0 Entry Point:=A0 00000000<br>
=A0=A0 Verifying Checksum ... OK<br>
=A0=A0 Uncompressing Kernel Image ... OK<br>
=A0=A0 Booting using the fdt at 0x900000<br>
=A0=A0 Loading Device Tree to 007fc000, end 007fefff ... OK<br>
Using MPC834x ITX machine description<br>
Linux version 2.6.29 (root@localhost.localdomain) (gcc version 4.1.2) #1 Th=
u De9console [udbg0] enabled<br>
setup_arch: bootmem<br>
mpc834x_itx_setup_arch()<br>
Found FSL PCI host bridge at 0x00000000e0008600. Firmware bus number: 1-&gt=
;1<br>
PCI host bridge /pci@e0008600=A0 ranges:<br>
=A0MEM 0x00000000a0000000..0x00000000afffffff -&gt; 0x00000000a0000000 Pref=
etch<br>
=A0MEM 0x00000000b0000000..0x00000000bfffffff -&gt; 0x00000000b0000000<br>
=A0 IO 0x00000000e3000000..0x00000000e3ffffff -&gt; 0x0000000000000000<br>
arch: exit<br>
Zone PFN ranges:<br>
=A0 DMA=A0=A0=A0=A0=A0 0x00000000 -&gt; 0x00008000<br>
=A0 Normal=A0=A0 0x00008000 -&gt; 0x00008000<br>
=A0 HighMem=A0 0x00008000 -&gt; 0x00008000<br>
Movable zone start PFN for each node<br>
early_node_map[1] active PFN ranges<br>
=A0=A0=A0 0: 0x00000000 -&gt; 0x00008000<br>
Built 1 zonelists in Zone order, mobility grouping on.=A0 Total pages: 3251=
2<br>
Kernel command line: root=3D/dev/ram rw console=3DttyS0,115200 mem=3D128M<b=
r>
IPIC (128 IRQ sources) at fe7fc700<br>
BUG: spinlock bad magic on CPU#0, swapper/0<br>
=A0lock: c041c3b8, .magic: dead4ead, .owner: &lt;none&gt;/-1, .owner_cpu: -=
1<br>
Call Trace:<br>
[c0449db0] [c0008990] show_stack+0x3c/0x160 (unreliable)<br>
[c0449de0] [c01fced8] spin_bug+0x8c/0xd0<br>
[c0449e00] [c01fd0e0] _raw_spin_lock+0x94/0x16c<br>
[c0449e30] [c02bcef0] _spin_lock_irqsave+0x20/0x38<br>
[c0449e50] [c004ea4c] down_trylock+0x18/0x4c<br>
[c0449e60] [c0032650] try_acquire_console_sem+0x20/0x7c<br>
[c0449e70] [c0032de0] vprintk+0x148/0x3a4<br>
[c0449f20] [c003308c] printk+0x50/0x60<br>
[c0449f60] [c03f4e98] ipic_init+0x17c/0x180<br>
[c0449fa0] [c03fa7dc] mpc834x_itx_init_IRQ+0x2c/0x40<br>
[c0449fb0] [c03ebee8] init_IRQ+0x24/0x34<br>
[c0449fc0] [c03e570c] start_kernel+0x158/0x2b4<br>
[c0449ff0] [00003438] 0x3438<br>
PID hash table entries: 512 (order: 9, 2048 bytes)<br>
time_init: decrementer frequency =3D 66.666666 MHz<br>
time_init: processor frequency=A0=A0 =3D 399.999996 MHz<br>
clocksource: timebase mult[3c00001] shift[22] registered<br>
clockevent: decrementer mult[1111] shift[16] cpu[0]<br>
Console: colour dummy device 80x25<br>
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)<br>
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)<br>
High memory: 0k<br>
Memory: 124912k/131072k available (4188k kernel code, 6008k reserved,
192k data)SLUB: Genslabs=3D12, HWalign=3D32, Order=3D0-3, MinObjects=3D0,
CPUs=3D1, Nodes=3D1<br>
Calibrating delay loop... 133.12 BogoMIPS (lpj=3D266240)<br>
Mount-cache hash table entries: 512<br>
khelper used greatest stack depth: 7656 bytes left<br>
=A0=A0=A0=A0=A0=A0=A0=A0 Unable to handle kernel paging request for data at=
 address 0xffff3f60<br>
Faulting instruction address: 0xc005e984<br>
Oops: Kernel access of bad area, sig: 11 [#1]<br>
MPC834x ITX<br>
NIP: c005e984 LR: c005eae8 CTR: c005eb48<br>
REGS: c781dd00 TRAP: 0300=A0=A0 Not tainted=A0 (2.6.29)<br>
MSR: 00009032 &lt;EE,ME,IR,DR&gt;=A0 CR: 22000088=A0 XER: 00000000<br>
DAR: ffff3f60, DSISR: 20000000<br>
TASK =3D c7818000[1] &#39;swapper&#39; THREAD: c781c000<br>
GPR00: c005eae8 c781ddb0 c7818000 ffff3f60 c03c1300 fffedb2b 00000100 00000=
000<br>
GPR08: c0427c84 ffff3f60 00000001 c0440000 42000084 ffffffff 0fff7000 00800=
000<br>
GPR16: ffffffff 00000000 007fff00 00000000 00000001 c0470000 c0478d1c c03a0=
000<br>
GPR24: 00000001 c0470000 0000000a c781c000 00009032 00000000 c0478ce0 c0427=
c64<br>
NIP [c005e984] __rcu_process_callbacks+0x12c/0x2f0<br>
LR [c005eae8] __rcu_process_callbacks+0x290/0x2f0<br>
Call Trace:<br>
[c781ddb0] [c005eae8] __rcu_process_callbacks+0x290/0x2f0 (unreliable)<br>
[c781ddd0] [c005eb68] rcu_process_callbacks+0x20/0x44<br>
[c781dde0] [c0038244] __do_softirq+0x90/0x140<br>
[c781de20] [c0006534] do_softirq+0x58/0x5c<br>
[c781de30] [c00380a0] irq_exit+0x48/0x58<br>
[c781de40] [c0010e64] timer_interrupt+0x12c/0x188<br>
[c781de60] [c0014484] ret_from_except+0x0/0x14<br>
--- Exception: 901 at udbg_550_putc+0x1c/0x58<br>
=A0=A0=A0 LR =3D udbg_puts+0x48/0x6c<br>
[c781df20] [00000000] (null) (unreliable)<br>
[c781df30] [c03ee80c] udbg_progress+0x14/0x30<br>
[c781df40] [c03ee8f8] ppc_init+0x3c/0x68<br>
[c781df50] [c0003884] do_one_initcall+0x34/0x1a8<br>
[c781dfd0] [c03e516c] kernel_init+0x94/0xf8<br>
[c781dff0] [c0013c10] kernel_thread+0x4c/0x68<br>
Instruction dump:<br>
39200000 901e0008 913e0004 801f0000 901e0000 807e0024 2f830000 419e0090<br>
7c691b78 3ba00000 48000008 41920038 &lt;83e90000&gt; 2e1f0000 41920008 7c00=
fa2c<br>
Kernel panic - not syncing: Fatal exception in interrupt<br>
<br>
<br>
<br>
<br><br><div><span class=3D"gmail_quote">On 12/11/09, <b class=3D"gmail_sen=
dername">Scott Wood</b> &lt;<a href=3D"mailto:scottwood@freescale.com">scot=
twood@freescale.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" =
style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8=
ex; padding-left: 1ex;">
<span class=3D"q">Junita Ajith wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Scott:<br>
<br>
I am still stuck at Linux kernel booting in MPC8343EA based board.<br>
<br>
I have disabled &quot;Ethernet, PCI, USB, dma engines &quot; in the *.dts f=
ile and also in the kernel config.<br>
I am using MPC8349emitxgp.dts =A0; enabled MPC8349ITX support in
kernel config also. In fact, I tried building MPC8349emITX; MPC8349MDS
also. Same behaviour!<br>
<br>
With this, the kernel boots up (explicitly passing the DTB file and cuImage=
 NEVER worked) and hangs after<br>
<br>
I am using Linux-V-2.6.27.18 and using powerpc-e300c3-gnu
=A0toolchain =A0- gcc-4.1.69-eglibc-2.5.69-1 to build
u-boot-1.3.2 &amp; linux.<br>
<br>
With this, the kernel boots up (explicitly passing the DTB file and cuImage=
 NEVER worked) and hangs after printing<br>
&quot;Calibrating delay loop... 133.12 BogoMIPS (lpj=3D266240)&quot;<br>
<br>
With a few debug printks looks like the kernel hangs in<br>
&quot;cpu_idle&quot; in --main/init.c<br>
</blockquote>
<br></span>
Try to find out what threads are blocked where.<br>
<br>
There may also have been a problem transitioning to the normal serial
driver. =A0Do you have an external debugger than can extract the log
buffer?<br><span class=3D"sg">
<br>
-Scott<br>
</span></blockquote></div><br>

--00504502bc3430705a047a79162d--
