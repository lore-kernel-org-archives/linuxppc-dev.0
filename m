Return-Path: <herminio.hernandezjr@gmail.com>
Received: from mail-wm0-x22e.google.com (mail-wm0-x22e.google.com
 [IPv6:2a00:1450:400c:c09::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sdTBJ2XJZzDsfj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 13:43:36 +1000 (AEST)
Received: by mail-wm0-x22e.google.com with SMTP id l132so11428072wmf.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 20:43:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <28807f61-b73e-b695-ea6a-cb51c1554144@daenzer.net>
References: <CANtoAtPSgkxEvAdOs-gZGOECYN8OFTvwRrsg+US41ji1fGEDLA@mail.gmail.com>
 <969BB53B-CB30-49DC-B6C5-4D2381ECE6EE@gmail.com>
 <CANtoAtN1K3OAoXsgeMOWui_jEZO3X1fJAmRX-LeO_Du8h3T9kg@mail.gmail.com>
 <1472122446.2246.93.camel@kernel.crashing.org> <57DF23C4.20508@gmail.com>
 <CAJRA9dwyJ+5XuD7i0ktwvx3Md9p_Z9tiVZCWvO_gK1kfG-+ccA@mail.gmail.com>
 <CA+7wUsyOSCJzymLe7vyub8dvyvsEDuVU0auO2rGi6ohkBKBEoQ@mail.gmail.com>
 <28807f61-b73e-b695-ea6a-cb51c1554144@daenzer.net>
From: "Herminio Hernandez, Jr." <herminio.hernandezjr@gmail.com>
Date: Mon, 19 Sep 2016 20:43:32 -0700
Message-ID: <CAJRA9dydVbEB3HdL_YMZPBkhtiq-REVZTtoK7gTEgdb8MMOxLg@mail.gmail.com>
Subject: Re: PowerPC agpmode issues
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc: Mathieu Malaterre <malat@debian.org>, Mike <michael.heltne@gmail.com>,
 "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Pranith Kumar <bobby.prani@gmail.com>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>
Content-Type: multipart/alternative; boundary=001a11464cac966547053ce83bf1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a11464cac966547053ce83bf1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Michel,

Yes to both, however when I set radeon.agpmode=3D1 most of the time the
kernel freezes when booting. When I do get past that I get these errors:

rican-linux@Debian-G5:~$ dmesg |grep -e radeon -e drm
*[    0.000000] Kernel command line:
root=3DUUID=3Daeca9a67-31d7-4c4b-a0f8-4db328b33305  radeon.agpmode=3D1*
[   10.432049] [drm] Initialized drm 1.1.0 20060810
[   11.291427] [drm] radeon kernel modesetting enabled.
[   11.302838] fb: switching to radeondrmfb from OFfb ATY,Simone
[   11.317952] fb: switching to radeondrmfb from OFfb ATY,Simone
[   11.321318] radeon 0000:f0:10.0: enabling device (0006 -> 0007)
[   11.321741] [drm] initializing kernel modesetting (RV350 0x1002:0x4150
0x1002:0x4150 0x00).
[   11.321770] [drm] register mmio base: 0xA0000000
[   11.321776] [drm] register mmio size: 65536
[   11.321820] radeon 0000:f0:10.0: Invalid PCI ROM header signature:
expecting 0xaa55, got 0x0000
[   11.415530] [drm] Not an x86 BIOS ROM, not using.
[   11.415573] [drm] Using device-tree clock info
*[   11.415769] [drm:.radeon_agp_init [radeon]] *ERROR* Illegal AGP Mode: 1
(valid 4, 8), leaving at 8*
[   11.415818] radeon 0000:f0:10.0: putting AGP V3 device into 8x mode
[   11.415925] radeon 0000:f0:10.0: GTT: 256M 0x00000000 - 0x0FFFFFFF
[   11.415933] [drm] Generation 2 PCI interface, using max accessible memor=
y
[   11.415943] radeon 0000:f0:10.0: VRAM: 256M 0x00000000B0000000 -
0x00000000BFFFFFFF (64M used)
[   11.415987] [drm] Detected VRAM RAM=3D256M, BAR=3D256M
[   11.415993] [drm] RAM width 128bits DDR
[   11.416229] [drm] radeon: 64M of VRAM memory ready
[   11.416237] [drm] radeon: 256M of GTT memory ready.
[   11.416308] [drm] radeon: 1 quad pipes, 1 Z pipes initialized.
[   11.431606] radeon 0000:f0:10.0: WB disabled
[   11.431627] radeon 0000:f0:10.0: fence driver on ring 0 use gpu addr
0x0000000000000000 and cpu addr 0xd000000003ee0000
[   11.431642] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   11.431648] [drm] Driver supports precise vblank timestamp query.
[   11.431700] [drm] radeon: irq initialized.
[   11.431743] [drm] Loading R300 Microcode
[   11.488921] radeon 0000:f0:10.0: firmware: direct-loading firmware
radeon/R300_cp.bin
[   11.489178] [drm] radeon: ring at 0x0000000000010000





*[   11.637210] [drm:.r100_ring_test [radeon]] *ERROR* radeon: ring test
failed (scratch(0x15E4)=3D0xCAFEDEAD)[   11.637318] [drm:.r100_cp_init
[radeon]] *ERROR* radeon: cp isn't working (-22).[   11.637331] radeon
0000:f0:10.0: failed initializing CP (-22).[   11.637338] radeon
0000:f0:10.0: Disabling GPU acceleration[   11.784325] [drm:.r100_cp_fini
[radeon]] *ERROR* Wait for CP idle timeout, shutting down CP.[   11.931351]
[drm] radeon: cp finalized*



*[   11.931464] radeon 0000:f0:10.0: (r300_asic_reset:425)
RBBM_STATUS=3D0x80010140[   12.431463] radeon 0000:f0:10.0:
(r300_asic_reset:444) RBBM_STATUS=3D0x80010140[   12.927471] radeon
0000:f0:10.0: (r300_asic_reset:456) RBBM_STATUS=3D0x00000140[   12.927510]
radeon 0000:f0:10.0: GPU reset succeed*



On Mon, Sep 19, 2016 at 8:05 PM, Michel D=C3=A4nzer <michel@daenzer.net> wr=
ote:

> On 19/09/16 09:36 PM, Mathieu Malaterre wrote:
> >
> > Finally your dmesg looks odd since the line `[drm] Forcing AGP to PCI
> > mode` comes only after the first error.
>
> That isn't odd but the AGP->PCI(e) fallback mechanism working as
> intended, trying AGP first and falling back to PCIe if AGP fails.
>
> Herminio, does the problem also occur if you specify radeon.agpmode=3D-1
> (or maybe =3D1) on the kernel command line?
>
>
> --
> Earthling Michel D=C3=A4nzer               |               http://www.amd=
.com
> Libre software enthusiast             |             Mesa and X developer
>

--001a11464cac966547053ce83bf1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Michel,<br><br></div>Yes to both, however when I set =
radeon.agpmode=3D1 most of the time the kernel freezes when booting. When I=
 do get past that I get these errors:<br><br>rican-linux@Debian-G5:~$ dmesg=
 |grep -e radeon -e drm<br><b>[=C2=A0=C2=A0=C2=A0 0.000000] Kernel command =
line: root=3DUUID=3Daeca9a67-31d7-4c4b-a0f8-4db328b33305=C2=A0 radeon.agpmo=
de=3D1</b><br>[=C2=A0=C2=A0 10.432049] [drm] Initialized drm 1.1.0 20060810=
<br>[=C2=A0=C2=A0 11.291427] [drm] radeon kernel modesetting enabled.<br>[=
=C2=A0=C2=A0 11.302838] fb: switching to radeondrmfb from OFfb ATY,Simone<b=
r>[=C2=A0=C2=A0 11.317952] fb: switching to radeondrmfb from OFfb ATY,Simon=
e<br>[=C2=A0=C2=A0 11.321318] radeon 0000:f0:10.0: enabling device (0006 -&=
gt; 0007)<br>[=C2=A0=C2=A0 11.321741] [drm] initializing kernel modesetting=
 (RV350 0x1002:0x4150 0x1002:0x4150 0x00).<br>[=C2=A0=C2=A0 11.321770] [drm=
] register mmio base: 0xA0000000<br>[=C2=A0=C2=A0 11.321776] [drm] register=
 mmio size: 65536<br>[=C2=A0=C2=A0 11.321820] radeon 0000:f0:10.0: Invalid =
PCI ROM header signature: expecting 0xaa55, got 0x0000<br>[=C2=A0=C2=A0 11.=
415530] [drm] Not an x86 BIOS ROM, not using.<br>[=C2=A0=C2=A0 11.415573] [=
drm] Using device-tree clock info<br><b>[=C2=A0=C2=A0 11.415769] [drm:.rade=
on_agp_init [radeon]] *ERROR* Illegal AGP Mode: 1 (valid 4, 8), leaving at =
8</b><br>[=C2=A0=C2=A0 11.415818] radeon 0000:f0:10.0: putting AGP V3 devic=
e into 8x mode<br>[=C2=A0=C2=A0 11.415925] radeon 0000:f0:10.0: GTT: 256M 0=
x00000000 - 0x0FFFFFFF<br>[=C2=A0=C2=A0 11.415933] [drm] Generation 2 PCI i=
nterface, using max accessible memory<br>[=C2=A0=C2=A0 11.415943] radeon 00=
00:f0:10.0: VRAM: 256M 0x00000000B0000000 - 0x00000000BFFFFFFF (64M used)<b=
r>[=C2=A0=C2=A0 11.415987] [drm] Detected VRAM RAM=3D256M, BAR=3D256M<br>[=
=C2=A0=C2=A0 11.415993] [drm] RAM width 128bits DDR<br>[=C2=A0=C2=A0 11.416=
229] [drm] radeon: 64M of VRAM memory ready<br>[=C2=A0=C2=A0 11.416237] [dr=
m] radeon: 256M of GTT memory ready.<br>[=C2=A0=C2=A0 11.416308] [drm] rade=
on: 1 quad pipes, 1 Z pipes initialized.<br>[=C2=A0=C2=A0 11.431606] radeon=
 0000:f0:10.0: WB disabled<br>[=C2=A0=C2=A0 11.431627] radeon 0000:f0:10.0:=
 fence driver on ring 0 use gpu addr 0x0000000000000000 and cpu addr 0xd000=
000003ee0000<br>[=C2=A0=C2=A0 11.431642] [drm] Supports vblank timestamp ca=
ching Rev 2 (21.10.2013).<br>[=C2=A0=C2=A0 11.431648] [drm] Driver supports=
 precise vblank timestamp query.<br>[=C2=A0=C2=A0 11.431700] [drm] radeon: =
irq initialized.<br>[=C2=A0=C2=A0 11.431743] [drm] Loading R300 Microcode<b=
r>[=C2=A0=C2=A0 11.488921] radeon 0000:f0:10.0: firmware: direct-loading fi=
rmware radeon/R300_cp.bin<br>[=C2=A0=C2=A0 11.489178] [drm] radeon: ring at=
 0x0000000000010000<br><b>[=C2=A0=C2=A0 11.637210] [drm:.r100_ring_test [ra=
deon]] *ERROR* radeon: ring test failed (scratch(0x15E4)=3D0xCAFEDEAD)<br>[=
=C2=A0=C2=A0 11.637318] [drm:.r100_cp_init [radeon]] *ERROR* radeon: cp isn=
&#39;t working (-22).<br>[=C2=A0=C2=A0 11.637331] radeon 0000:f0:10.0: fail=
ed initializing CP (-22).<br>[=C2=A0=C2=A0 11.637338] radeon 0000:f0:10.0: =
Disabling GPU acceleration<br>[=C2=A0=C2=A0 11.784325] [drm:.r100_cp_fini [=
radeon]] *ERROR* Wait for CP idle timeout, shutting down CP.<br>[=C2=A0=C2=
=A0 11.931351] [drm] radeon: cp finalized</b><br><b>[=C2=A0=C2=A0 11.931464=
] radeon 0000:f0:10.0: (r300_asic_reset:425) RBBM_STATUS=3D0x80010140<br>[=
=C2=A0=C2=A0 12.431463] radeon 0000:f0:10.0: (r300_asic_reset:444) RBBM_STA=
TUS=3D0x80010140<br>[=C2=A0=C2=A0 12.927471] radeon 0000:f0:10.0: (r300_asi=
c_reset:456) RBBM_STATUS=3D0x00000140<br>[=C2=A0=C2=A0 12.927510] radeon 00=
00:f0:10.0: GPU reset succeed</b><br><br><br></div><div class=3D"gmail_extr=
a"><br><div class=3D"gmail_quote">On Mon, Sep 19, 2016 at 8:05 PM, Michel D=
=C3=A4nzer <span dir=3D"ltr">&lt;<a href=3D"mailto:michel@daenzer.net" targ=
et=3D"_blank">michel@daenzer.net</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><span class=3D"">On 19/09/16 09:36 PM, Mathieu Malaterre wrot=
e:<br>
&gt;<br>
&gt; Finally your dmesg looks odd since the line `[drm] Forcing AGP to PCI<=
br>
&gt; mode` comes only after the first error.<br>
<br>
</span>That isn&#39;t odd but the AGP-&gt;PCI(e) fallback mechanism working=
 as<br>
intended, trying AGP first and falling back to PCIe if AGP fails.<br>
<br>
Herminio, does the problem also occur if you specify radeon.agpmode=3D-1<br=
>
(or maybe =3D1) on the kernel command line?<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
--<br>
Earthling Michel D=C3=A4nzer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=
=3D"http://www.amd.com" rel=3D"noreferrer" target=3D"_blank">http://www.amd=
.com</a><br>
Libre software enthusiast=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mesa and X developer<br>
</div></div></blockquote></div><br></div>

--001a11464cac966547053ce83bf1--
