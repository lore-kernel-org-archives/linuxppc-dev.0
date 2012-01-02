Return-Path: <Farrukh_Arshad@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "relay1.mentorg.com",
 Issuer "Entrust Certification Authority - L1B" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 415E61007D2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jan 2012 06:10:40 +1100 (EST)
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
 by relay1.mentorg.com with esmtp
 id 1RhnHI-0005XB-F2 from Farrukh_Arshad@mentor.com
 for linuxppc-dev@lists.ozlabs.org; Mon, 02 Jan 2012 11:10:36 -0800
From: "Arshad, Farrukh" <Farrukh_Arshad@mentor.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Problem in getting shared memory access on P1022RDK
Date: Mon, 2 Jan 2012 19:10:33 +0000
Message-ID: <93CD5F41FDBC6042A6B449764F3B35CC050CCA22@EU-MBX-03.mgc.mentorg.com>
Content-Type: multipart/alternative;
 boundary="_000_93CD5F41FDBC6042A6B449764F3B35CC050CCA22EUMBX03mgcmento_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_93CD5F41FDBC6042A6B449764F3B35CC050CCA22EUMBX03mgcmento_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Greetings All,

Please excuse me for a 'not very precise' question but I just need some clu=
e or point to look for the trouble.
I am running linux in AMP configuration on P1022RDK dual core. My memory pa=
rtitioning is given below

Core Base Address (CONFIG_PHYSICAL_START / bootm_low) Size (bootm_size / me=
m kernel boot parameter)
Core 0 0x0000,0000 0x1000,0000
Core 1 0x1000,0000 0x0C00,0000
Shared Memory 0x1C00,0000 0x0400,0000

I have set bootm_low / bootm_size and provided mem parameter in both kernel=
 configurations, both
kernels are booting up fine. I have a shared memory driver running in both =
cores. My shared memory
driver just exposes the physical memory (0x1C00,0000) to user-space.

The problem I am facing is I can not get access to same shared memory in us=
er-space on both kernels.
I have verified my shared memory driver on another platform (p1022ds) and i=
t works perfect. I have also
tried using non-cached memory mapping in shared memory driver but that does=
 not work as well.

To me it seems one of my kernels is going beyond its defined memory partiti=
on (which I have set above), I have
set kernel's partitioning as CONFIG_PHYSICAL_START, bootm_size, bootm_low a=
nd mem kernel boot param.

Besides the shared memory driver, can anyone suggest or give me clue where =
should I look for the
trouble in the kernel.

Regards,
Farrukh Arshad.

--_000_93CD5F41FDBC6042A6B449764F3B35CC050CCA22EUMBX03mgcmento_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html dir=3D"ltr">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" id=3D"owaParaStyle"></style>
</head>
<body fpstyle=3D"1" ocsi=3D"0">
<div style=3D"direction: ltr;font-family: Tahoma;color: #000000;font-size: =
10pt;">
<div>Greetings All,</div>
<div><br>
</div>
<div>Please excuse me for a 'not very precise' question but I just need som=
e clue or point to look for the trouble.</div>
<div>I am running linux in AMP configuration on P1022RDK dual core. My memo=
ry partitioning is given below</div>
<div><br>
</div>
<div>Core<span class=3D"Apple-tab-span" style=3D"white-space:pre"> </span>B=
ase Address (CONFIG_PHYSICAL_START / bootm_low)<span class=3D"Apple-tab-spa=
n" style=3D"white-space:pre">
</span>Size (bootm_size / mem kernel boot parameter)</div>
<div>Core 0<span class=3D"Apple-tab-span" style=3D"white-space:pre"> </span=
>0x0000,0000<span class=3D"Apple-tab-span" style=3D"white-space:pre">
</span>0x1000,0000</div>
<div>Core 1<span class=3D"Apple-tab-span" style=3D"white-space:pre"> </span=
>0x1000,0000<span class=3D"Apple-tab-span" style=3D"white-space:pre">
</span>0x0C00,0000</div>
<div>Shared Memory<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
 </span>0x1C00,0000<span class=3D"Apple-tab-span" style=3D"white-space:pre"=
>
</span>0x0400,0000</div>
<div><br>
</div>
<div>I have set bootm_low / bootm_size and provided mem parameter in both k=
ernel configurations, both&nbsp;</div>
<div>kernels are booting up fine. I have a shared memory driver running in =
both cores. My shared memory&nbsp;</div>
<div>driver just exposes the physical memory (0x1C00,0000) to user-space.&n=
bsp;</div>
<div><br>
</div>
<div>The problem I am facing is I can not get access to same shared memory =
in user-space on both kernels.</div>
<div>I have verified my shared memory driver on another platform (p1022ds) =
and it works perfect. I have also&nbsp;</div>
<div>tried using non-cached memory mapping in shared memory driver but that=
 does not work as well.&nbsp;</div>
<div><br>
</div>
<div>To me it seems one of my kernels is going beyond its defined memory pa=
rtition (which I have set above), I have&nbsp;</div>
<div>set kernel's partitioning as CONFIG_PHYSICAL_START, bootm_size, bootm_=
low and mem kernel boot param.</div>
<div><br>
</div>
<div>Besides the shared memory driver, can anyone suggest or give me clue w=
here should I look for the&nbsp;</div>
<div>trouble in the kernel.</div>
<div><br>
</div>
<div>Regards,</div>
<div>Farrukh Arshad.</div>
</div>
</body>
</html>

--_000_93CD5F41FDBC6042A6B449764F3B35CC050CCA22EUMBX03mgcmento_--
