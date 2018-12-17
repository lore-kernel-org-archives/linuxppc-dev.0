Return-Path: <SRS0=wNeI=O2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,URI_HEX,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D58CC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 01:30:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCE992084D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 01:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE992084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43J3WX1RnpzDqfG
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 12:30:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmx.net
 (client-ip=212.227.15.19; helo=mout.gmx.net;
 envelope-from=j.neuschaefer@gmx.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=gmx.net
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43J3TG692NzDqdm
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Dec 2018 12:28:48 +1100 (AEDT)
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M3zne-1hOk210HAI-00rbq2; Mon, 17
 Dec 2018 02:28:39 +0100
Date: Mon, 17 Dec 2018 02:28:37 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v1 03/13] powerpc/mm/32s: rework mmu_mapin_ram()
Message-ID: <20181217012837.GT15324@latitude>
References: <cover.1543517818.git.christophe.leroy@c-s.fr>
 <8835330baa77d88e0267b0b1215b78c991e6d17a.1543517818.git.christophe.leroy@c-s.fr>
 <20181203215558.GK15324@latitude>
 <84624899-bbda-9f08-2527-151fddbd1b01@c-s.fr>
 <a253e9f8-1e0a-1596-e0ea-54261ac62212@c-s.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JvUS8mwutKMHKosv"
Content-Disposition: inline
In-Reply-To: <a253e9f8-1e0a-1596-e0ea-54261ac62212@c-s.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:ZI56TBnuAhL5ePdX04oQh3qW31r/x3JfrBpLfQWtFemTcTFJ5of
 14nHYoGPiRZoAq+Vhzz2rpxni+WA6qDczNJ91xt8zeBLmdf4tEVkSwwcWRp/eQzvfg4GPsR
 2AZ+qOujjt4KyXgEHY9wo1kbQ9Wk+nb8955eTtYGmBklVMJD/ObDoCuL3zsE/wHQCy0Uwlx
 51p3XiS94r0KqyOowsSqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MFVEMhV54H0=:Btg9wheFXYMeR6rrEkSdWc
 Woh20USWCh3lNUTMxmUT6G06ajkmpVvCU2P5RIHrkGduVm9WmyRi7RBOzaMhdPrEgZ9ZN7azs
 cCfgvqsz237CdvNWj4AkF3CejJU9+FDsgGcbsq4eiIjT0kBHv28nhpGhkVUtGMq0Dy+LELU+E
 EMzIVXvnhs9Qaw7fZ8c1L7VTtpGwScM8iCide/FEeZCa6APzbxQ3LqcYOKEBC5NlJypGJUFEi
 7kzGxUXKFPdo+hRAxcBM9OzklV+edGuqK/ExJMsZUpexxXYMgPNmIV0aK9LJsBN14DyMOXoVw
 9FszaHSGQpBzYcvtC1L6bBrT01vJn4ICJFvu6FFCV42hxS04ggrY+pPXElA2stQ+SLWL+vS5c
 bBQjYyqeNVcSLAoOeQafvP68DpEf1f3WidbK7me0B0XauLhiW80cw/LMw36i7SeOg3vWD15ic
 QE4IvUkVmWx3UuTobuy0shBD0ihTjayU1v9DWd1i7yXVw9iovbHBJl/VauCoCOPfwGvHMg4vP
 aWs7eif2/fFgo+PepTkgptY3uI4x3F5rtZ9U6EtXlfn8wm/flREAuDlTSh640ZOxtVHe1DWo2
 Cxy3Gxr9gd3DVwY5aIWEOlrOHaI5Zt81bwxl/CnZDm0bexsi1jgKptMeIqnX0FyPfKfP+F7Rh
 LvDQ5ePGeNXRiSAWAlmWylws1RNgsmLut9/Elyr/mUK91RFPXiYJQ5sxgFrC2aPVau4RjjpBH
 osslDGpQ0v7atqPULP9bKtKkmtPRRgNWDbNQ45z4LwUXd1r1WxkPjkLBhXWwayLET7Nd0l9No
 9F9tm8pexI4sV3BET9QlMMTsTjKmOnwUrVkPJfKeTc4JUelDJyDhHztnKnx0hmZT9zXEe1dma
 8JN5i4fSaCRGf+REiBDdOtLO8DpHxb9aJxF3rmtrAA67GT+6/wm6cMArelWtCO
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--JvUS8mwutKMHKosv
Content-Type: multipart/mixed; boundary="ai3I8gwHc37+ASRI"
Content-Disposition: inline


--ai3I8gwHc37+ASRI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi, thanks for your reply.

On Thu, Dec 13, 2018 at 03:51:32PM +0100, Christophe Leroy wrote:
> Hi Again,
>=20
> Le 13/12/2018 =C3=A0 13:16, Christophe Leroy a =C3=A9crit=C2=A0:
[...]
> > Can you tell/provide the .config and dts used ?

I'm using wii.dts and almost the wii_defconfig from my tree (save-
defconfig result is attached), which is 4.20-rc5 plus a few patches:

  https://github.com/neuschaefer/linux wii-4.20-rc5        (w/o your patche=
s)
  https://github.com/neuschaefer/linux wii-4.20-rc5-ppcbat (w/ your patches=
 1-3)

> > You seem to have 319MB RAM wherease arch/powerpc/boot/dts/wii.dts only
> > has 88MB Memory:
> >=20
> >  =C2=A0=C2=A0=C2=A0=C2=A0memory {
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device_type =3D "memory";
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x00000000 0x01800=
000=C2=A0=C2=A0=C2=A0 /* MEM1 24MB 1T-SRAM */
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x10000000 0x04000000>;=C2=A0=C2=A0=C2=A0 /* MEM2 64MB GDDR=
3 */
> >  =C2=A0=C2=A0=C2=A0=C2=A0};

This is, I think, because something marks all the address space from 0
to the end of MEM2 as RAM, and then cuts out a hole in the middle. I'm
not sure about the exact mechanism.

Unfortunately this hole has to be treated carefully because it contains
MMIO devices.

> Putting the same description in my mpc832x board DTS and doing a few hacks
> to get the WII functions called, I get the following:
>=20
> [    0.000000] Top of RAM: 0x14000000, Total RAM: 0x5800000
> [    0.000000] Memory hole size: 232MB
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000000000000-0x0000000013ffffff]
> [    0.000000]   Normal   empty
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000000000-0x00000000017fffff]
> [    0.000000]   node   0: [mem 0x0000000010000000-0x0000000013ffffff]
> [    0.000000] Initmem setup node 0 [mem
> 0x0000000000000000-0x0000000013ffffff]
> [    0.000000] On node 0 totalpages: 22528
> [    0.000000]   DMA zone: 640 pages used for memmap
> [    0.000000]   DMA zone: 0 pages reserved
> [    0.000000]   DMA zone: 22528 pages, LIFO batch:3
> [    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=3D1*32768
> [    0.000000] pcpu-alloc: [0] 0
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 218=
88
> [    0.000000] Kernel command line: loglevel=3D7
> ip=3D192.168.2.5:192.168.2.2::255.0
> [    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536
> bytes)
> [    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 byte=
s)
> [    0.000000] Memory: 77060K/90112K available (6548K kernel code, 1156K
> rwdata,
> [    0.000000] Kernel virtual memory layout:
> [    0.000000]   * 0xfffdf000..0xfffff000  : fixmap
> [    0.000000]   * 0xfdffd000..0xfe000000  : early ioremap
> [    0.000000]   * 0xd5000000..0xfdffd000  : vmalloc & ioremap
>=20
>=20
>=20
>=20
> root@vgoippro:~# cat /sys/kernel/debug/powerpc/block_address_translation
> ---[ Instruction Block Address Translation ]---
> 0: 0xc0000000-0xc0ffffff 0x00000000 Kernel EXEC coherent
> 1:         -
> 2: 0xc1000000-0xc17fffff 0x01000000 Kernel EXEC coherent
> 3:         -
> 4: 0xd0000000-0xd3ffffff 0x10000000 Kernel EXEC coherent
> 5:         -
> 6:         -
> 7:         -
>=20
> ---[ Data Block Address Translation ]---
> 0: 0xc0000000-0xc0ffffff 0x00000000 Kernel RW coherent
> 1: 0xfffe0000-0xffffffff 0x0d000000 Kernel RW no cache guarded
> 2: 0xc1000000-0xc17fffff 0x01000000 Kernel RW coherent
> 3:         -
> 4: 0xd0000000-0xd3ffffff 0x10000000 Kernel RW coherent
> 5:         -
> 6:         -
> 7:         -
>=20
>=20
> Could you please provide the dmesg and
> /sys/kernel/debug/powerpc/block_address_translation from before this patc=
h,
> so that we can compare and identify the differences if any ?

After applying the patch that adds this debugfs file and enabling
CONFIG_PPC_PTDUMP, I get this:

	# cat /sys/kernel/debug/powerpc/block_address_translation
	---[ Instruction Block Address Translation ]---
	0:         -
	1:         -
	2: 0xc0000000-0xc0ffffff 0x00000000 Kernel EXEC
	3: 0xc1000000-0xc17fffff 0x01000000 Kernel EXEC
	4: 0xd0000000-0xd1ffffff 0x10000000 Kernel EXEC
	5:         -
	6:         -
	7:         -

	---[ Data Block Address Translation ]---
	0:         -
	1: 0xfffe0000-0xffffffff 0x0d000000 Kernel RW no cache guarded
	2: 0xc0000000-0xc0ffffff 0x00000000 Kernel RW
	3: 0xc1000000-0xc17fffff 0x01000000 Kernel RW
	4: 0xd0000000-0xd1ffffff 0x10000000 Kernel RW
	5:         -
	6:         -
	7:         -

dmesg is attached.


I added some tracing to the setbat function:

diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index f6f575bae3bc..4da3dc54fe46 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -120,6 +120,9 @@ void __init setbat(int index, unsigned long virt, phys_=
addr_t phys,
 	struct ppc_bat *bat =3D BATS[index];
 	unsigned long flags =3D pgprot_val(prot);
=20
+	pr_info("setbat(%u, %px, %px, %px, %lx)\n",
+			index, (void *)virt, (void *)phys, (void *)size, flags);
+
 	if ((flags & _PAGE_NO_CACHE) ||
 	    (cpu_has_feature(CPU_FTR_NEED_COHERENT) =3D=3D 0))
 		flags &=3D ~_PAGE_COHERENT;


And here's what I got:

Before your patches (circa v4.20-rc5):
[    0.000000] setbat(2, c0000000, 00000000, 01000000, 591)
[    0.000000] setbat(3, c1000000, 01000000, 00800000, 591)
[    0.000000] setbat(4, d0000000, 10000000, 02000000, 591)

With patches 1-3:
[    0.000000] setbat(0, c0000000, 00000000, 01000000, 311)
[    0.000000] setbat(2, c1000000, 01000000, 00800000, 311)
[    0.000000] setbat(4, d0000000, 10000000, 02000000, 791)

According to arch/powerpc/include/asm/book3s/32/hash.h,
 - 0x591 =3D _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_COHERENT | _PA=
GE_PRESENT
 - 0x311 =3D _PAGE_EXEC | _PAGE_ACCESSED | _PAGE_COHERENT | _PAGE_PRESENT
 - 0x791 =3D _PAGE_RW | _PAGE_EXEC | _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_C=
OHERENT | _PAGE_PRESENT

Changing the flags back to 0x591 in setbat doesn't result in a booting
system.


> > > I've tested at patch 1, 2, 3, 4, and 13, so I don't know if it works
> > > somewhere in the middle, but probably not.

(I get the same results if I also merge powerpc/next, btw)


I hope this helps somewhat,
  Jonathan Neusch=C3=A4fer

--ai3I8gwHc37+ASRI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="wii-dmesg.txt"

[    0.000000] printk: bootconsole [udbg0] enabled
[    0.000000] Total memory = 319MB; using 1024kB for hash table (at (ptrval))
[    0.000000] Linux version 4.20.0-rc5-wii-00021-g15eb67569a3d (jn@longitude) (gcc version 8.2.0 (Debian 8.2.0-9)) #1337 PREEMPT Sun Dec 16 02:37:19 CET 2018
[    0.000000] Using wii machine description
[    0.000000] -----------------------------------------------------
[    0.000000] Hash_size         = 0x100000
[    0.000000] phys_mem_size     = 0x5700000
[    0.000000] dcache_bsize      = 0x20
[    0.000000] icache_bsize      = 0x20
[    0.000000] cpu_features      = 0x000000000401a008
[    0.000000]   possible        = 0x000000002f7ff049
[    0.000000]   always          = 0x0000000000000000
[    0.000000] cpu_user_features = 0x8c000001 0x00000000
[    0.000000] mmu_features      = 0x00010001
[    0.000000] Hash              = 0x(ptrval)
[    0.000000] Hash_mask         = 0x3fff
[    0.000000] -----------------------------------------------------
[    0.000000] wii: hw_ctrl at 0x0d800100 mapped to 0x(ptrval)
[    0.000000] wii: hw_gpio at 0x0d8000c0 mapped to 0x(ptrval)
[    0.000000] Top of RAM: 0x13f00000, Total RAM: 0x5700000
[    0.000000] Memory hole size: 232MB
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x0000000013efffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x00000000017fffff]
[    0.000000]   node   0: [mem 0x0000000010000000-0x0000000013efffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x0000000013efffff]
[    0.000000] On node 0 totalpages: 22272
[    0.000000]   DMA zone: 638 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 22272 pages, LIFO batch:3
[    0.000000] random: get_random_u32 called from start_kernel+0x84/0x438 with crng_init=0
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 21634
[    0.000000] Kernel command line: root=/dev/mmcblk0p2 rootwait console=usbgecko1
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 73016K/89088K available (7084K kernel code, 512K rwdata, 1796K rodata, 2724K init, 158K bss, 16072K reserved, 0K cma-reserved)
[    0.000000] Kernel virtual memory layout:
[    0.000000]   * 0xfffdf000..0xfffff000  : fixmap
[    0.000000]   * 0xfde00000..0xfe000000  : consistent mem
[    0.000000]   * 0xfddfe000..0xfde00000  : early ioremap
[    0.000000]   * 0xd4000000..0xfddfe000  : vmalloc & ioremap
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000]  Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] NR_IRQS: 512, nr_irqs: 512, preallocated irqs: 16
[    0.000000] flipper-pic: controller at 0x0c003000 mapped to 0x(ptrval)
[    0.000000] hlwd-pic: controller at 0x0d800030 mapped to 0x(ptrval)
[    0.000000] time_init: decrementer frequency = 60.750000 MHz
[    0.000000] time_init: processor frequency   = 729.000000 MHz
[    0.000012] clocksource: timebase: mask: 0xffffffffffffffff max_cycles: 0x1c0588ffb6, max_idle_ns: 881590404504 ns
[    0.004906] clocksource: timebase mult[83afef2] shift[23] registered
[    0.007920] clockevent: decrementer mult[f8d4fdf] shift[32] cpu[0]
[    0.011235] Console: colour dummy device 80x25
[    0.013381] pid_max: default: 32768 minimum: 301
[    0.015704] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.018862] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.023818] rcu: Hierarchical SRCU implementation.
[    0.026863] devtmpfs: initialized
[    0.057205] DMA-API: preallocated 65536 debug entries
[    0.059600] DMA-API: debugging enabled by kernel config
[    0.062146] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.066813] futex hash table entries: 256 (order: 0, 7168 bytes)
[    0.070472] NET: Registered protocol family 16
[    0.074531] exi: Nintendo GameCube/Wii EXternal Interface (EXI) driver - version 4.0i
[    0.079457] exi: about to add [exi0:0] id=0xfffffffe (external card)
[    0.082855] exi: add completed
[    0.084329] exi: about to add [exi0:1] id=0xfffff308 Wii Mask ROM/RTC/SRAM/UART
[    0.088140] exi: add completed
[    0.129762] SCSI subsystem initialized
[    0.131853] Advanced Linux Sound Architecture Driver Initialized.
[    0.138423] Bluetooth: Core ver 2.22
[    0.140835] NET: Registered protocol family 31
[    0.142944] Bluetooth: HCI device and connection manager initialized
[    0.146378] Bluetooth: HCI socket layer initialized
[    0.148693] Bluetooth: L2CAP socket layer initialized
[    0.151303] Bluetooth: SCO socket layer initialized
[    0.153707] clocksource: Switched to clocksource timebase
[    0.236624] NET: Registered protocol family 2
[    0.239818] tcp_listen_portaddr_hash hash table entries: 256 (order: 0, 6144 bytes)
[    0.243850] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
[    0.247389] TCP bind hash table entries: 1024 (order: 2, 20480 bytes)
[    0.250658] TCP: Hash tables configured (established 1024 bind 1024)
[    0.253850] UDP hash table entries: 256 (order: 1, 12288 bytes)
[    0.256758] UDP-Lite hash table entries: 256 (order: 1, 12288 bytes)
[    0.260147] NET: Registered protocol family 1
[    0.262867] RPC: Registered named UNIX socket transport module.
[    0.265675] RPC: Registered udp transport module.
[    0.267974] RPC: Registered tcp transport module.
[    0.270219] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.584441] Initialise system trusted keyrings
[    0.588214] workingset: timestamp_bits=30 max_order=15 bucket_order=0
[    0.682925] Key type asymmetric registered
[    0.684871] Asymmetric key parser 'x509' registered
[    0.687476] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    0.691178] io scheduler noop registered
[    0.693039] io scheduler deadline registered
[    0.695278] io scheduler cfq registered (default)
[    0.697511] io scheduler mq-deadline registered
[    0.699746] io scheduler kyber registered
[    0.755731] usbgecko: Console and TTY driver for the USB Gecko adapter - version 0.1i
[    0.760106] usbgecko: USB Gecko detected in memcard slot-A
[    1.341534] printk: console [usbgecko0] enabled
[    1.346940] Generic non-volatile memory driver v1.1
[    1.354626] brd: module loaded
[    1.372181] loop: module loaded
[    1.376667] Broadcom 43xx driver loaded [ Features: NS ]
[    1.383138] i2c /dev entries driver
[    1.388232] sdhci: Secure Digital Host Controller Interface driver
[    1.395102] sdhci: Copyright(c) Pierre Ossman
[    1.399557] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.405551] mmc0 bounce up to 128 segments into one, max segment size 65536 bytes
[    1.437737] mmc0: SDHCI controller on d070000.sd [d070000.sd] using DMA
[    1.444910] mmc1 bounce up to 128 segments into one, max segment size 65536 bytes
[    1.477741] mmc1: SDHCI controller on d080000.sdio [d080000.sdio] using DMA
[    1.488556] NET: Registered protocol family 17
[    1.500457] Bluetooth: RFCOMM socket layer initialized
[    1.506001] Bluetooth: RFCOMM ver 1.11
[    1.510150] mmc0: new high speed SDHC card at address 1234
[    1.515730] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    1.523394] mmcblk0: mmc0:1234 SA32G 28.9 GiB
[    1.527978] Bluetooth: BNEP filters: multicast
[    1.533692] Bluetooth: BNEP socket layer initialized
[    1.539240] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[    1.545434]  mmcblk0: p1
[    1.548923] Bluetooth: HIDP socket layer initialized
[    1.555729] drmem: No dynamic reconfiguration memory found
[    1.563332] Loading compiled-in X.509 certificates
[    1.568179] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
[    1.575175] input: gpio-keys as /devices/platform/gpio-keys/input/input0
[    1.583075] hctosys: unable to open rtc device (rtc0)
[    1.588566] mmc1: queuing unknown CIS tuple 0x80 (5 bytes)
[    1.594391] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    1.603328] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
[    1.614717] mmc1: queuing unknown CIS tuple 0x80 (5 bytes)
[    1.624477] random: fast init done
[    1.632755] mmc1: queuing unknown CIS tuple 0x80 (10 bytes)
[    1.643310] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    1.650089] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
[    1.655619] ALSA device list:
[    1.658623]   No soundcards found.
[    1.662253] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
[    1.674115] mmc1: queuing unknown CIS tuple 0x80 (5 bytes)
[    1.680759] Freeing unused kernel memory: 2724K
[    1.685600] mmc1: queuing unknown CIS tuple 0x80 (4 bytes)
[    1.691121] This architecture does not have kernel memory protection.
[    1.697611] mmc1: new SDIO card at address 0001
[    1.702178] Run /init as init process
[    1.706477] b43-sdio mmc1:0001:1: Chip ID 14e4:4318
[    1.716390] ssb: Found chip with id 0x4710, rev 0x00 and package 0x00
[    1.736283] ssb: WARNING: Multiple ChipCommon found
[    1.750060] b43-phy0: Broadcom 4710 WLAN found (core revision 9)
[    1.768026] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    1.785099] cfg80211: failed to load regulatory.db
[    1.794322] b43-phy0: Found PHY: Analog 3, Type 2 (G), Revision 7
[    1.806215] b43-phy0: Found Radio: Manuf 0x17F, ID 0x2050, Revision 8, Version 0
[    1.878936] b43-sdio mmc1:0001:1: Sonics Silicon Backplane found on SDIO device mmc1:0001:1
[    1.907732] udevd[615]: starting version 3.2.5
[    1.921820] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
[    1.937066] random: udevd: uninitialized urandom read (16 bytes read)
[    1.945644] random: udevd: uninitialized urandom read (16 bytes read)
[    1.952679] random: udevd: uninitialized urandom read (16 bytes read)
[    1.974388] udevd[616]: starting eudev-3.2.5
[    3.055809] random: dd: uninitialized urandom read (512 bytes read)

--ai3I8gwHc37+ASRI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=wii-conf

CONFIG_LOCALVERSION="-wii"
CONFIG_SYSVIPC=y
CONFIG_PREEMPT=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE="/home/jn/dev/linux/gc-linux/buildroot/images/rootfs.cpio"
CONFIG_EXPERT=y
# CONFIG_ELF_CORE is not set
CONFIG_PERF_EVENTS=y
# CONFIG_VM_EVENT_COUNTERS is not set
CONFIG_SLAB=y
# CONFIG_PPC_CHRP is not set
# CONFIG_PPC_PMAC is not set
CONFIG_EMBEDDED6xx=y
CONFIG_WII=y
# CONFIG_PPC_OF_BOOT_TRAMPOLINE is not set
CONFIG_KEXEC=y
# CONFIG_SECCOMP is not set
CONFIG_ADVANCED_OPTIONS=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_BINFMT_MISC=m
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_RARP=y
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET_XFRM_MODE_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_BEET is not set
# CONFIG_INET_DIAG is not set
# CONFIG_IPV6 is not set
CONFIG_BT=y
CONFIG_BT_RFCOMM=y
CONFIG_BT_BNEP=y
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_HIDP=y
CONFIG_CFG80211=y
CONFIG_MAC80211=y
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
CONFIG_DEVTMPFS=y
# CONFIG_STANDALONE is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=2
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_NETDEVICES=y
# CONFIG_ETHERNET is not set
CONFIG_B43=y
CONFIG_B43_BUSES_SSB=y
CONFIG_B43_SDIO=y
# CONFIG_B43_PHY_LP is not set
CONFIG_B43_DEBUG=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y
# CONFIG_KEYBOARD_ATKBD is not set
CONFIG_KEYBOARD_GPIO=y
# CONFIG_MOUSE_PS2 is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_UINPUT=y
# CONFIG_SERIO_I8042 is not set
# CONFIG_SERIO_SERPORT is not set
CONFIG_LEGACY_PTY_COUNT=64
CONFIG_SERIAL_USBGECKO=y
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=y
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_GPIO=y
CONFIG_GPIOLIB=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_HLWD=y
CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_GPIO=y
# CONFIG_HWMON is not set
CONFIG_FB=y
# CONFIG_VGA_CONSOLE is not set
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
# CONFIG_SND_VERBOSE_PROCFS is not set
CONFIG_SND_SEQUENCER=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_HID_APPLE=m
CONFIG_MMC=y
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_PLTFM=y
CONFIG_MMC_SDHCI_OF_HLWD=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_PANIC=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_DRV_GENERIC=y
CONFIG_EXT2_FS=y
CONFIG_EXT4_FS=y
CONFIG_FUSE_FS=m
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_PROC_KCORE=y
# CONFIG_PROC_PAGE_MONITOR is not set
CONFIG_TMPFS=y
CONFIG_NFS_FS=y
CONFIG_ROOT_NFS=y
CONFIG_CIFS=m
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
# CONFIG_CRYPTO_HW is not set
CONFIG_CRC_CCITT=y
CONFIG_PRINTK_TIME=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_LATENCYTOP=y
CONFIG_SCHED_TRACER=y
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_DMA_API_DEBUG=y
CONFIG_PPC_EARLY_DEBUG=y
CONFIG_PPC_PTDUMP=y

--ai3I8gwHc37+ASRI--

--JvUS8mwutKMHKosv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlwW+70ACgkQCDBEmo7z
X9vcMA//ciZ9SwCND+3gviqqufTkAIOoTfrZgtZcUC6t/GUGI/5bd99wJx2nl6GM
b+cvU3AiS6LNB2KvRhxFjlzkzfX26heeDtk6yHHVP4O1hMkyYhmCQM5RZYbKw42P
Hixz2HVo/l3w5yy7F48LuDd2J12nAIgU5DrPbqzDltWddENDSKVU3oADA4gJVjVl
3y+VfsAbPOjB0bXCaYqshOiOPATxViuAKJ/krMTXsSkSTo9eLPNdKslXH2Q76GeS
z7RNKrKFZZjRtgQ46Yt8AlHqqewNrM+BN9lvjd3DvgFTsxQeVPIEs2cMi24wKJof
/5hWK7mZFdp/kUErKhHWEduG9IcOHPkenchHEMBaCOds5W8d4JZ4MTX2lWzDYSaH
RN/N0eUCW5K7LTJ+MsZD5wVale1/C5TRIMsRUBHy5JCoKT9tDM0VnPPsCLX3AFJy
QsB0P3T0IiTKYOeScp7gTCIM17WyabB/14EUXx0P44TaFXV1AhrrPEXk1rT4JbbW
pN7tzWKyJf6bxjIhXU5Flk7opXnRP9kduS7AMli3auU5+lgSGjnUQX0i65ILqKA0
K0dybFJz7AuAr47bbwz+Utwt8jt1/0xnT9g1AnUvCoE5MlEs0mKmeIXgRch/63On
aDDsftANFa4MrrAjVyUZ0Phrf56ahm6AN1m/7nk/5KL0V+ZDV6k=
=O4FN
-----END PGP SIGNATURE-----

--JvUS8mwutKMHKosv--
