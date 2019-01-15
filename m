Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A992C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 00:36:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D29AF20657
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 00:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D29AF20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43drwy68mPzDqXL
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 11:36:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmx.net
 (client-ip=212.227.17.22; helo=mout.gmx.net;
 envelope-from=j.neuschaefer@gmx.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=gmx.net
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43drtz5bsSzDqSW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 11:34:19 +1100 (AEDT)
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MBq8p-1gZY1a2Nr5-00AotK; Tue, 15
 Jan 2019 01:33:57 +0100
Date: Tue, 15 Jan 2019 01:33:53 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v2 00/15] powerpc/32s: Use BATs/LTLBs for STRICT_KERNEL_RWX
Message-ID: <20190115003353.GD22334@latitude>
References: <cover.1547132681.git.christophe.leroy@c-s.fr>
 <20190113181621.GA22334@latitude>
 <714e78ba-1e92-a856-3dd6-a1fb96ad3785@c-s.fr>
 <20190113210227.GB22334@latitude>
 <334b1b02-b652-499c-904e-09e6f7164b8c@c-s.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bajzpZikUji1w+G9"
Content-Disposition: inline
In-Reply-To: <334b1b02-b652-499c-904e-09e6f7164b8c@c-s.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:Tfh0fcp34orf31kcItygfZLkfrZbBJ+FOFepaLkVb1SRYkAJCYD
 M2eEo5Cow34rmP4j5IEiSzCuXaVooXksBmMF2YPCrl730991juZBa0Ia050Dwz7eNkD0OGB
 LteqvK/pRcyt/g7+/2JI9dKPKB8L8RnLB0E+I4D7c+wMO4fv/XuOkig7Gl2SfV0D6eguIGi
 dsA8LhLyhSSBpZHN9WMIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oatbJL0eozI=:SX4sEgMVISdz9JW9RDfPfr
 m3ye04VpyQUQqo1ufJKCL4Pe/iuq/vZS7WPwzq0+fcapYPCov8PNROmIqWMXZlhjgpqfMmz/M
 3lCMONlG7onctMza3psDvpp2UnSIj+hD+JrLEdF3VAjJlKLhJuZ6blVa/0oC8+caZelvomyKn
 86CsyMm36/HtCe3wws6jjHUeuQqJDrUlhUZWg7TOlqKL8xpIftmCGac31pKZlU36/Drm+vjsm
 NQ6gPELHMENh8gd1ZRO1c3esVm5V3VioOvkr2FyEl4iRBDAgkVGWsN49WrDxZ6T5hqEz+WMYJ
 xKF5BssKjdDypAodcLT8khaQLSSZlATjJhTRLReGMqMrUV3g7TxYSGH2SRgJpap+knDKz0EI1
 KtIRrjmP7LC1hE8kHozPlxgqlDtHHeBdqtF/owVPpXB/rCeMdkGdu+QndzGScb0WhxG4aVbty
 0qGRaFklG6Fa/J79e8Tkqqkd3aYU1EFKAt/SgVledIlwsYJggXLEiDDTHgIaClkqSUfvy3UwZ
 Fk7M16XIqI13pcYnqhd9kSbmf9NstD84WFAcNA7ZrMYxs08/QSqisfjk0HGA1GTuP5GZMiWYg
 GIjehRe7y1PHW96EhaLmQcjQE2e+YLx76/8ukj3T+qRFiOAYFE3PzhXNP/RoImM91Vqr37XiZ
 Egk3IXo1o0QEBf1f5mq7uRb3Hv2doI/JQi8bGgSlAEgo/wISi9uBLgxNPDh/swqA/RWn9Rfhq
 xIudADjVPyOj5EHYlmIflJCHmeVav76HJcZLOp/B46z/S0SBuJKpMYRWMfRPL47wP6wKL4O6y
 33OPPIon8tAQLa/WXdy03+AjPxlafnbxDEMFuk+NcVWFgqz7rGGIdvvf5wI0CoKwWehBfKH5n
 4G9AhhF12C9nvvtHpVfFhCwEqWtri+7007uoICskbEkl0F/B8bZkdh8/eXvcV4
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
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--bajzpZikUji1w+G9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2019 at 07:23:07PM +0100, Christophe Leroy wrote:
>=20
>=20
> Le 13/01/2019 =C3=A0 22:02, Jonathan Neusch=C3=A4fer a =C3=A9crit=C2=A0:
> > On Sun, Jan 13, 2019 at 08:43:07PM +0100, Christophe Leroy wrote:
> > > Le 13/01/2019 =C3=A0 19:16, Jonathan Neusch=C3=A4fer a =C3=A9crit=C2=
=A0:
> > > > I just tested the whole series on my Wii (I didn't test any interme=
diate
> > > > steps). Without CONFIG_STRICT_KERNEL_RWX, it seems to work fine, but
> > > > with it, I get the following error while booting:
[...]
> I can't see anything special in your setup, and this failure looks rather
> unexpected because I can't see anything done that early when
> CONFIG_STRICT_KERNEL_RWX is selected.
>=20
> Does CONFIG_STRICT_KERNEL_RWX works properly without my serie ?

I hadn't tried this before, but yes, without this series (on v5.0-rc2),
a kernel with CONFIG_STRICT_KERNEL_RWX boots.

I've checked it patch-by-patch now (with STRICT_KERNEL_RWX):

- patches 1 and 2 build and boot fine
- patches 3 to 6 build, but fail to boot with this error:

	top of MEM2 @ 13F00000

	zImage starting: loaded at 0x00e00000 (sp: 0x01588fa0)
	Allocating 0x14e92c8 bytes for kernel...
	Decompressing (0x00000000 <- 0x00e11000:0x01586ba7)...
	Done! Decompressed 0xdc01f4 bytes

	Linux/PowerPC load: root=3D/dev/mmcblk0p2 rootwait console=3Dusbgecko1
	Finalizing device tree... flat tree at 0x15897a0
	[    0.000000] printk: bootconsole [udbg0] enabled
	[    0.000000] Total memory =3D 319MB; using 1024kB for hash table (at (pt=
rval))
	[    0.000000] RAM mapped without BATs
	[    0.000000] RAM mapped without BATs
	[    0.000000] ------------[ cut here ]------------
	[    0.000000] kernel BUG at arch/powerpc/mm/pgtable_32.c:223!
	[    0.000000] Oops: Exception in kernel mode, sig: 5 [#1]
	[    0.000000] BE PREEMPT
	[    0.000000] Modules linked in:
	[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc1-wii-00024=
-g596f9fe23c13 #1337
	[    0.000000] NIP:  c0017c4c LR: c0a836a0 CTR: c001edc4
	[    0.000000] REGS: c0d9deb0 TRAP: 0700   Not tainted  (5.0.0-rc1-wii-000=
24-g596f9fe23c13)
	[    0.000000] MSR:  00020030 <IR,DR>  CR: 42000888  XER: 20000000
	[    0.000000]
	[    0.000000] GPR00: c0a836a0 c0d9df60 c0d2a4a0 c0d29c00 00000000 c16ff00=
0 c0d9de28 c0dc0000
	[    0.000000] GPR08: c0d9c000 00000001 00000001 00000000 28000824 0000000=
0 00000000 00000000
	[    0.000000] GPR16: 00000000 00000000 00000020 00000000 c0860000 c0da000=
0 c0000000 c0a7d000
	[    0.000000] GPR24: c0acd55c c0d487c8 13f00000 c0d29000 00000c00 0000031=
1 c0000000 c0d487c8
	[    0.000000] NIP [c0017c4c] map_kernel_page+0x78/0xf0
	[    0.000000] LR [c0a836a0] mapin_ram+0xe0/0x14c
	[    0.000000] Call Trace:
	[    0.000000] [c0d9df60] [c0a83f54] mmu_mapin_ram+0x54/0x1a4 (unreliable)
	[    0.000000] [c0d9df90] [c0a836a0] mapin_ram+0xe0/0x14c
	[    0.000000] [c0d9dfd0] [c0a83578] MMU_init+0x158/0x1a0
	[    0.000000] [c0d9dff0] [c0003418] start_here+0x40/0x78
	[    0.000000] Instruction dump:
	[    0.000000] 55290026 57c5b53a 7ca54a14 3d204000 7f854800 3ca5c000 419e0=
088 81250000
	[    0.000000] 552afffe 552907fe 7d4a4b79 4082004c <0f0a0000> 54840026 7c8=
4eb78 9081000c
	[    0.000000] random: get_random_bytes called from print_oops_end_marker+=
0x34/0x6c with crng_init=3D0
	[    0.000000] ---[ end trace 0000000000000000 ]---
	[    0.000000]
	[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
	[    0.000000] Rebooting in 180 seconds..

- patches 7 to 11 fail to build with this error (really a warning, but
  arch/powerpc doesn't allow warnings by default):

	  CC      arch/powerpc/mm/ppc_mmu_32.o
	../arch/powerpc/mm/ppc_mmu_32.c:133:13: error: =E2=80=98clearibat=E2=80=99=
 defined but not used [-Werror=3Dunused-function]
	 static void clearibat(int index)
		     ^~~~~~~~~
	../arch/powerpc/mm/ppc_mmu_32.c:115:13: error: =E2=80=98setibat=E2=80=99 d=
efined but not used [-Werror=3Dunused-function]
	 static void setibat(int index, unsigned long virt, phys_addr_t phys,
		     ^~~~~~~
	cc1: all warnings being treated as errors

- patches 12 to 15 build but fail to boot with this error:

	top of MEM2 @ 13F00000

	zImage starting: loaded at 0x01000000 (sp: 0x0178afa0)
	Allocating 0x166b2c8 bytes for kernel...
	Decompressing (0x00000000 <- 0x01011000:0x017880ce)...
	Done! Decompressed 0xf421f4 bytes

	Linux/PowerPC load: root=3D/dev/mmcblk0p2 rootwait console=3Dusbgecko1
	Finalizing device tree... flat tree at 0x178b7a0
	[    0.000000] printk: bootconsole [udbg0] enabled
	[    0.000000] Kernel panic - not syncing: ERROR: Failed to allocate 0x001=
00000 bytes below 0x00000000.
	[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc1-wii-00033=
-gc263f8162122 #1337
	[    0.000000] Call Trace:
	[    0.000000] [c0f1ff30] [c00280f0] panic+0x144/0x324 (unreliable)
	[    0.000000] [c0f1ff90] [c0c18a34] memblock_alloc_base+0x34/0x44
	[    0.000000] [c0f1ffa0] [c0c071e0] MMU_init_hw+0xcc/0x300
	[    0.000000] [c0f1ffd0] [c0c06554] MMU_init+0x12c/0x198
	[    0.000000] [c0f1fff0] [c0003418] start_here+0x40/0x78
	[    0.000000] Rebooting in 180 seconds..


I'll investigate some more tomorrow.

Jonathan

--bajzpZikUji1w+G9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlw9KmgACgkQCDBEmo7z
X9sofQ//W5ASkLAU3PgbijtwwedphsCQH89lxAdJU6zL5nOG2kZ8SffLiKKVrBkx
O6SCWEdFX7j5TwOQNEBTa0hoWWfRQOytPLP3gbX4rxNgCe16y/fapMklEUq4QmLG
GKVw8EBXcGm4CkgQvjDPJ+F8np1chHdsAGWo6k6XGtpd6useD/qOOr7NLu5DWfrZ
GyFvO/vNS/V+QZqmkTo6n2f2UBZXDcD6YyPZqllYPcZdjZmj7qPUzKTlZwbwAaha
66Or2RfJ38sLuL0CBaonfquErNCReppXecNz+jA0HIa4AQWKXFt4Pk59O1sGF5a7
autgwzDZECYW8CqF5WvZzdu65NT0eFM9PkHVd6HytAYaB+x8/5IBPLOKnRWht25P
qrcr4335xB5CLWWYccH1wwKOeKQnV1LrR7NZz6Q4iBvhq+kXpvPM6a7EbytjZ0Yk
P8aTUGZQbRM3gj8oqqyPa6tVXRXmoKlWwM7++Fi2od23+q1AV1ID6TL2Ml4h0HwY
Old86XpcdaJoGghkoXNPEhCBmpviRJ2lYMhuybMhIiwitUrZQsWT7+43pguPiuVv
uMmZChwQJ5Yjj7C8k+Q0egTqd1M8kIeUkeNHcdAUeAmZn6KfOpNsKmuijNsaM4u8
5IofLxLKQsMW5tbYMGqi/2sRmwwwtzO16ganRpaO3txlpEa7OR4=
=pTfv
-----END PGP SIGNATURE-----

--bajzpZikUji1w+G9--
