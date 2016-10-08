Return-Path: <herminio.hernandezjr@gmail.com>
Received: from mail-wm0-x231.google.com (mail-wm0-x231.google.com
 [IPv6:2a00:1450:400c:c09::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3srwnF4nR8zDrSJ
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Oct 2016 06:05:05 +1100 (AEDT)
Received: by mail-wm0-x231.google.com with SMTP id b201so100861295wmb.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Oct 2016 12:05:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJRA9dzE4UehiMRfA0-MPfEVjyxgGLdg=SKN_w_19q4YtdHHtQ@mail.gmail.com>
References: <CANtoAtPSgkxEvAdOs-gZGOECYN8OFTvwRrsg+US41ji1fGEDLA@mail.gmail.com>
 <969BB53B-CB30-49DC-B6C5-4D2381ECE6EE@gmail.com>
 <CANtoAtN1K3OAoXsgeMOWui_jEZO3X1fJAmRX-LeO_Du8h3T9kg@mail.gmail.com>
 <1472122446.2246.93.camel@kernel.crashing.org> <57DF23C4.20508@gmail.com>
 <CAJRA9dwyJ+5XuD7i0ktwvx3Md9p_Z9tiVZCWvO_gK1kfG-+ccA@mail.gmail.com>
 <CA+7wUsyOSCJzymLe7vyub8dvyvsEDuVU0auO2rGi6ohkBKBEoQ@mail.gmail.com>
 <28807f61-b73e-b695-ea6a-cb51c1554144@daenzer.net>
 <CAJRA9dydVbEB3HdL_YMZPBkhtiq-REVZTtoK7gTEgdb8MMOxLg@mail.gmail.com>
 <260ec14e-c103-0f1d-e459-2ef421f2a207@daenzer.net>
 <CAJRA9dzE4UehiMRfA0-MPfEVjyxgGLdg=SKN_w_19q4YtdHHtQ@mail.gmail.com>
From: "Herminio Hernandez, Jr." <herminio.hernandezjr@gmail.com>
Date: Sat, 8 Oct 2016 12:05:01 -0700
Message-ID: <CAJRA9dwwiOYfJR7fGUtZp2FYfqagw+Fq8QKj9H8tA7y97Qq0wg@mail.gmail.com>
Subject: Re: PowerPC agpmode issues
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc: Mathieu Malaterre <malat@debian.org>, Mike <michael.heltne@gmail.com>,
 "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Pranith Kumar <bobby.prani@gmail.com>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>
Content-Type: multipart/alternative; boundary=94eb2c1313ea4009ee053e5f3415
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--94eb2c1313ea4009ee053e5f3415
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Performed an apt dist-upgrade and rebooted with agpmode=3D4 and still the G=
PU
is failing with errors. Should I proceed to place a bug report on this?

Herminio

On Tue, Sep 20, 2016 at 11:20 PM, Herminio Hernandez, Jr. <
herminio.hernandezjr@gmail.com> wrote:

> I am still getting errors even with radeon.agpmode=3D4 is set
>
> rican-linux@Debian-G5:~$ dmesg |grep -e radeom -e drm -e radeon.agpmode
> [    0.000000] Kernel command line: root=3DUUID=3Daeca9a67-31d7-4c4b-a0f8=
-4db328b33305
> radeon.agpmode=3D4
> [    9.734366] [drm] Initialized drm 1.1.0 20060810
> [   10.934519] [drm] radeon kernel modesetting enabled.
> [   10.943743] fb: switching to radeondrmfb from OFfb ATY,Simone
> [   10.954622] fb: switching to radeondrmfb from OFfb ATY,Simone
> [   10.956515] [drm] initializing kernel modesetting (RV350 0x1002:0x4150
> 0x1002:0x4150 0x00).
> [   10.956552] [drm] register mmio base: 0xA0000000
> [   10.956558] [drm] register mmio size: 65536
> [   11.046327] [drm] Not an x86 BIOS ROM, not using.
> [   11.046358] [drm] Using device-tree clock info
> [   11.046369] [drm] AGP mode requested: 4
> [   11.046528] [drm] Generation 2 PCI interface, using max accessible
> memory
> [   11.046582] [drm] Detected VRAM RAM=3D256M, BAR=3D256M
> [   11.046587] [drm] RAM width 128bits DDR
> [   11.046858] [drm] radeon: 64M of VRAM memory ready
> [   11.046866] [drm] radeon: 256M of GTT memory ready.
> [   11.046935] [drm] radeon: 1 quad pipes, 1 Z pipes initialized.
> [   11.061306] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013)=
.
> [   11.061312] [drm] Driver supports precise vblank timestamp query.
> [   11.061363] [drm] radeon: irq initialized.
> [   11.061405] [drm] Loading R300 Microcode
> [   11.110467] [drm] radeon: ring at 0x0000000000010000
> [   11.257952] [drm:.r100_ring_test [radeon]] *ERROR* radeon: ring test
> failed (scratch(0x15E4)=3D0xCAFEDEAD)
> [   11.258060] [drm:.r100_cp_init [radeon]] *ERROR* radeon: cp isn't
> working (-22).
> [   11.404548] [drm:.r100_cp_fini [radeon]] *ERROR* Wait for CP idle
> timeout, shutting down CP.
> [   11.551199] [drm] radeon: cp finalized
> [   12.547388] [drm] radeon: cp finalized
> [   12.553854] [drm] radeon: ttm finalized
> [   12.553861] [drm] Forcing AGP to PCI mode
> [   12.643384] [drm] Not an x86 BIOS ROM, not using.
> [   12.643406] [drm] Using device-tree clock info
> [   12.643414] [drm] Generation 2 PCI interface, using max accessible
> memory
> [   12.643446] [drm] Detected VRAM RAM=3D256M, BAR=3D256M
> [   12.643452] [drm] RAM width 128bits DDR
> [   12.643712] [drm] radeon: 64M of VRAM memory ready
> [   12.643719] [drm] radeon: 512M of GTT memory ready.
> [   12.643761] [drm] GART: num cpu pages 8192, num gpu pages 131072
> [   12.645324] [drm] radeon: 1 quad pipes, 1 Z pipes initialized.
> [   12.645343] [drm] PCI GART of 512M enabled (table at
> 0x0000000062F80000).
> [   12.645462] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013)=
.
> [   12.645468] [drm] Driver supports precise vblank timestamp query.
> [   12.645512] [drm] radeon: irq initialized.
> [   12.645689] [drm] radeon: ring at 0x0000000090010000
> [   12.793131] [drm:.r100_ring_test [radeon]] *ERROR* radeon: ring test
> failed (scratch(0x15E4)=3D0xCAFEDEAD)
> [   12.793235] [drm:.r100_cp_init [radeon]] *ERROR* radeon: cp isn't
> working (-22).
> [   12.939961] [drm:.r100_cp_fini [radeon]] *ERROR* Wait for CP idle
> timeout, shutting down CP.
> [   12.940193] [drm] radeon: cp finalized
> [   12.944581] [drm] Connector Table: 12 (mac g5 9600)
> [   12.944609] [drm] No valid Ext TMDS info found in BIOS
> [   12.944621] [drm] No TV DAC info found in BIOS
> [   12.944798] [drm] No TMDS info found in BIOS
> [   12.944974] [drm] Radeon Display Connectors
> [   12.944981] [drm] Connector 0:
> [   12.944985] [drm]   DVI-I-1
> [   12.944990] [drm]   HPD1
> [   12.944995] [drm]   DDC: 0x64 0x64 0x64 0x64 0x64 0x64 0x64 0x64
> [   12.945000] [drm]   Encoders:
> [   12.945005] [drm]     DFP2: INTERNAL_DVO1
> [   12.945010] [drm]     CRT2: INTERNAL_DAC2
> [   12.945015] [drm] Connector 1:
> [   12.945019] [drm]   DVI-I-2
> [   12.945023] [drm]   HPD2
> [   12.945028] [drm]   DDC: 0x60 0x60 0x60 0x60 0x60 0x60 0x60 0x60
> [   12.945033] [drm]   Encoders:
> [   12.945037] [drm]     DFP1: INTERNAL_TMDS1
> [   12.945042] [drm]     CRT1: INTERNAL_DAC1
> [   12.945046] [drm] Connector 2:
> [   12.945051] [drm]   SVIDEO-1
> [   12.945055] [drm]   Encoders:
> [   12.945059] [drm]     TV1: INTERNAL_DAC2
> [   13.028211] [drm] fb mappable at 0xB0040000
> [   13.028229] [drm] vram apper at 0xB0000000
> [   13.028234] [drm] size 8323072
> [   13.028238] [drm] fb depth is 24
> [   13.028243] [drm]    pitch is 7680
> [   13.122329] radeon 0000:f0:10.0: fb0: radeondrmfb frame buffer device
> [   13.175092] [drm] Initialized radeon 2.43.0 20080528 for 0000:f0:10.0
> on minor 0
> rican-linux@Debian-G5:~$
>
>
> On Mon, Sep 19, 2016 at 11:20 PM, Michel D=C3=A4nzer <michel@daenzer.net>
> wrote:
>
>> On 20/09/16 12:43 PM, Herminio Hernandez, Jr. wrote:
>> >
>> > Yes to both, however when I set radeon.agpmode=3D1 most of the time th=
e
>> > kernel freezes when booting. When I do get past that I get these error=
s:
>>
>> [...]
>>
>> > *[   11.415769] [drm:.radeon_agp_init [radeon]] *ERROR* Illegal AGP
>> > Mode: 1 (valid 4, 8), leaving at 8*
>>
>> As you can see, AGP 1x isn't supported by your setup, only 4x or 8x. How
>> about radeon.agpmode=3D4?
>>
>>
>> --
>> Earthling Michel D=C3=A4nzer               |               http://www.am=
d.com
>> Libre software enthusiast             |             Mesa and X developer
>>
>
>

--94eb2c1313ea4009ee053e5f3415
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Performed an apt dist-upgrade and rebooted with agpmo=
de=3D4 and still the GPU is failing with errors. Should I proceed to place =
a bug report on this?<br><br></div>Herminio<br></div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Tue, Sep 20, 2016 at 11:20 PM, Hermi=
nio Hernandez, Jr. <span dir=3D"ltr">&lt;<a href=3D"mailto:herminio.hernand=
ezjr@gmail.com" target=3D"_blank">herminio.hernandezjr@gmail.com</a>&gt;</s=
pan> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">I am still g=
etting errors even with radeon.agpmode=3D4 is set<br><div><br>rican-linux@D=
ebian-G5:~$ dmesg |grep -e radeom -e drm -e radeon.agpmode<br>[=C2=A0=C2=A0=
=C2=A0 0.000000] Kernel command line: root=3DUUID=3Daeca9a67-31d7-4c4b-<wbr=
>a0f8-4db328b33305=C2=A0 radeon.agpmode=3D4<br>[=C2=A0=C2=A0=C2=A0 9.734366=
] [drm] Initialized drm 1.1.0 20060810<br>[=C2=A0=C2=A0 10.934519] [drm] ra=
deon kernel modesetting enabled.<br>[=C2=A0=C2=A0 10.943743] fb: switching =
to radeondrmfb from OFfb ATY,Simone<br>[=C2=A0=C2=A0 10.954622] fb: switchi=
ng to radeondrmfb from OFfb ATY,Simone<br>[=C2=A0=C2=A0 10.956515] [drm] in=
itializing kernel modesetting (RV350 0x1002:0x4150 0x1002:0x4150 0x00).<br>=
[=C2=A0=C2=A0 10.956552] [drm] register mmio base: 0xA0000000<br>[=C2=A0=C2=
=A0 10.956558] [drm] register mmio size: 65536<br>[=C2=A0=C2=A0 11.046327] =
[drm] Not an x86 BIOS ROM, not using.<br>[=C2=A0=C2=A0 11.046358] [drm] Usi=
ng device-tree clock info<br>[=C2=A0=C2=A0 11.046369] [drm] AGP mode reques=
ted: 4<br>[=C2=A0=C2=A0 11.046528] [drm] Generation 2 PCI interface, using =
max accessible memory<br>[=C2=A0=C2=A0 11.046582] [drm] Detected VRAM RAM=
=3D256M, BAR=3D256M<br>[=C2=A0=C2=A0 11.046587] [drm] RAM width 128bits DDR=
<br>[=C2=A0=C2=A0 11.046858] [drm] radeon: 64M of VRAM memory ready<br>[=C2=
=A0=C2=A0 11.046866] [drm] radeon: 256M of GTT memory ready.<br>[=C2=A0=C2=
=A0 11.046935] [drm] radeon: 1 quad pipes, 1 Z pipes initialized.<br>[=C2=
=A0=C2=A0 11.061306] [drm] Supports vblank timestamp caching Rev 2 (21.10.2=
013).<br>[=C2=A0=C2=A0 11.061312] [drm] Driver supports precise vblank time=
stamp query.<br>[=C2=A0=C2=A0 11.061363] [drm] radeon: irq initialized.<br>=
[=C2=A0=C2=A0 11.061405] [drm] Loading R300 Microcode<br>[=C2=A0=C2=A0 11.1=
10467] [drm] radeon: ring at 0x0000000000010000<br>[=C2=A0=C2=A0 11.257952]=
 [drm:.r100_ring_test [radeon]] *ERROR* radeon: ring test failed (scratch(0=
x15E4)=3D0xCAFEDEAD)<br>[=C2=A0=C2=A0 11.258060] [drm:.r100_cp_init [radeon=
]] *ERROR* radeon: cp isn&#39;t working (-22).<br>[=C2=A0=C2=A0 11.404548] =
[drm:.r100_cp_fini [radeon]] *ERROR* Wait for CP idle timeout, shutting dow=
n CP.<br>[=C2=A0=C2=A0 11.551199] [drm] radeon: cp finalized<br>[=C2=A0=C2=
=A0 12.547388] [drm] radeon: cp finalized<br>[=C2=A0=C2=A0 12.553854] [drm]=
 radeon: ttm finalized<br>[=C2=A0=C2=A0 12.553861] [drm] Forcing AGP to PCI=
 mode<br>[=C2=A0=C2=A0 12.643384] [drm] Not an x86 BIOS ROM, not using.<br>=
[=C2=A0=C2=A0 12.643406] [drm] Using device-tree clock info<br>[=C2=A0=C2=
=A0 12.643414] [drm] Generation 2 PCI interface, using max accessible memor=
y<br>[=C2=A0=C2=A0 12.643446] [drm] Detected VRAM RAM=3D256M, BAR=3D256M<br=
>[=C2=A0=C2=A0 12.643452] [drm] RAM width 128bits DDR<br>[=C2=A0=C2=A0 12.6=
43712] [drm] radeon: 64M of VRAM memory ready<br>[=C2=A0=C2=A0 12.643719] [=
drm] radeon: 512M of GTT memory ready.<br>[=C2=A0=C2=A0 12.643761] [drm] GA=
RT: num cpu pages 8192, num gpu pages 131072<br>[=C2=A0=C2=A0 12.645324] [d=
rm] radeon: 1 quad pipes, 1 Z pipes initialized.<br>[=C2=A0=C2=A0 12.645343=
] [drm] PCI GART of 512M enabled (table at 0x0000000062F80000).<br>[=C2=A0=
=C2=A0 12.645462] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013=
).<br>[=C2=A0=C2=A0 12.645468] [drm] Driver supports precise vblank timesta=
mp query.<br>[=C2=A0=C2=A0 12.645512] [drm] radeon: irq initialized.<br>[=
=C2=A0=C2=A0 12.645689] [drm] radeon: ring at 0x0000000090010000<br>[=C2=A0=
=C2=A0 12.793131] [drm:.r100_ring_test [radeon]] *ERROR* radeon: ring test =
failed (scratch(0x15E4)=3D0xCAFEDEAD)<br>[=C2=A0=C2=A0 12.793235] [drm:.r10=
0_cp_init [radeon]] *ERROR* radeon: cp isn&#39;t working (-22).<br>[=C2=A0=
=C2=A0 12.939961] [drm:.r100_cp_fini [radeon]] *ERROR* Wait for CP idle tim=
eout, shutting down CP.<br>[=C2=A0=C2=A0 12.940193] [drm] radeon: cp finali=
zed<br>[=C2=A0=C2=A0 12.944581] [drm] Connector Table: 12 (mac g5 9600)<br>=
[=C2=A0=C2=A0 12.944609] [drm] No valid Ext TMDS info found in BIOS<br>[=C2=
=A0=C2=A0 12.944621] [drm] No TV DAC info found in BIOS<br>[=C2=A0=C2=A0 12=
.944798] [drm] No TMDS info found in BIOS<br>[=C2=A0=C2=A0 12.944974] [drm]=
 Radeon Display Connectors<br>[=C2=A0=C2=A0 12.944981] [drm] Connector 0:<b=
r>[=C2=A0=C2=A0 12.944985] [drm]=C2=A0=C2=A0 DVI-I-1<br>[=C2=A0=C2=A0 12.94=
4990] [drm]=C2=A0=C2=A0 HPD1<br>[=C2=A0=C2=A0 12.944995] [drm]=C2=A0=C2=A0 =
DDC: 0x64 0x64 0x64 0x64 0x64 0x64 0x64 0x64<br>[=C2=A0=C2=A0 12.945000] [d=
rm]=C2=A0=C2=A0 Encoders:<br>[=C2=A0=C2=A0 12.945005] [drm]=C2=A0=C2=A0=C2=
=A0=C2=A0 DFP2: INTERNAL_DVO1<br>[=C2=A0=C2=A0 12.945010] [drm]=C2=A0=C2=A0=
=C2=A0=C2=A0 CRT2: INTERNAL_DAC2<br>[=C2=A0=C2=A0 12.945015] [drm] Connecto=
r 1:<br>[=C2=A0=C2=A0 12.945019] [drm]=C2=A0=C2=A0 DVI-I-2<br>[=C2=A0=C2=A0=
 12.945023] [drm]=C2=A0=C2=A0 HPD2<br>[=C2=A0=C2=A0 12.945028] [drm]=C2=A0=
=C2=A0 DDC: 0x60 0x60 0x60 0x60 0x60 0x60 0x60 0x60<br>[=C2=A0=C2=A0 12.945=
033] [drm]=C2=A0=C2=A0 Encoders:<br>[=C2=A0=C2=A0 12.945037] [drm]=C2=A0=C2=
=A0=C2=A0=C2=A0 DFP1: INTERNAL_TMDS1<br>[=C2=A0=C2=A0 12.945042] [drm]=C2=
=A0=C2=A0=C2=A0=C2=A0 CRT1: INTERNAL_DAC1<br>[=C2=A0=C2=A0 12.945046] [drm]=
 Connector 2:<br>[=C2=A0=C2=A0 12.945051] [drm]=C2=A0=C2=A0 SVIDEO-1<br>[=
=C2=A0=C2=A0 12.945055] [drm]=C2=A0=C2=A0 Encoders:<br>[=C2=A0=C2=A0 12.945=
059] [drm]=C2=A0=C2=A0=C2=A0=C2=A0 TV1: INTERNAL_DAC2<br>[=C2=A0=C2=A0 13.0=
28211] [drm] fb mappable at 0xB0040000<br>[=C2=A0=C2=A0 13.028229] [drm] vr=
am apper at 0xB0000000<br>[=C2=A0=C2=A0 13.028234] [drm] size 8323072<br>[=
=C2=A0=C2=A0 13.028238] [drm] fb depth is 24<br>[=C2=A0=C2=A0 13.028243] [d=
rm]=C2=A0=C2=A0=C2=A0 pitch is 7680<br>[=C2=A0=C2=A0 13.122329] radeon 0000=
:f0:10.0: fb0: radeondrmfb frame buffer device<br>[=C2=A0=C2=A0 13.175092] =
[drm] Initialized radeon 2.43.0 20080528 for 0000:f0:10.0 on minor 0<br>ric=
an-linux@Debian-G5:~$ <br><br></div></div><div class=3D"HOEnZb"><div class=
=3D"h5"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon, S=
ep 19, 2016 at 11:20 PM, Michel D=C3=A4nzer <span dir=3D"ltr">&lt;<a href=
=3D"mailto:michel@daenzer.net" target=3D"_blank">michel@daenzer.net</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex"><span>On 20/09/16 12:43 PM=
, Herminio Hernandez, Jr. wrote:<br>
&gt;<br>
&gt; Yes to both, however when I set radeon.agpmode=3D1 most of the time th=
e<br>
&gt; kernel freezes when booting. When I do get past that I get these error=
s:<br>
<br>
</span>[...]<br>
<br>
&gt; *[=C2=A0 =C2=A011.415769] [drm:.radeon_agp_init [radeon]] *ERROR* Ille=
gal AGP<br>
&gt; Mode: 1 (valid 4, 8), leaving at 8*<br>
<br>
As you can see, AGP 1x isn&#39;t supported by your setup, only 4x or 8x. Ho=
w<br>
about radeon.agpmode=3D4?<br>
<div class=3D"m_4701592182049131400HOEnZb"><div class=3D"m_4701592182049131=
400h5"><br>
<br>
--<br>
Earthling Michel D=C3=A4nzer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=
=3D"http://www.amd.com" rel=3D"noreferrer" target=3D"_blank">http://www.amd=
.com</a><br>
Libre software enthusiast=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mesa and X developer<br>
</div></div></blockquote></div><br></div>
</div></div></blockquote></div><br></div>

--94eb2c1313ea4009ee053e5f3415--
