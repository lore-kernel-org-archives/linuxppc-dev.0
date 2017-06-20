Return-Path: <christian.melki@ericsson.com>
Received: from sessmg23.ericsson.net (sessmg23.ericsson.net [193.180.251.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsV7H0lpqzDqhk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 00:08:25 +1000 (AEST)
From: Christian Melki <christian.melki@ericsson.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: PPC 266MHz 8347E slow kernel decompress
Date: Tue, 20 Jun 2017 13:53:12 +0000
Message-ID: <HE1PR0701MB21210811C948CF2969F96B1790C50@HE1PR0701MB2121.eurprd07.prod.outlook.com>
Content-Type: multipart/alternative;
 boundary="_000_HE1PR0701MB21210811C948CF2969F96B1790C50HE1PR0701MB2121_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_HE1PR0701MB21210811C948CF2969F96B1790C50HE1PR0701MB2121_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi.


I recently upgraded one of Ericssons platforms from a old 3.6.x to the late=
st 3.16.x LTS kernel.
It was a smooth upgrade, besides kernel decompression taking much longer to=
 complete. From like 2 seconds to 10-12 seconds.
I also tried a 4.10.z kernel with the same result.
The decompression code doesn't have any significant changes as far as I can=
 see. Maybe I am looking in the wrong place?
Did the ppc arch init change between 3.6.x and 3.16.x? I am thinking of cac=
he init, prefetch copy functions etc?
The old Redboot loader starts the kernel with caches off. Maybe the older i=
nit re-initialized the caches before decompression?
Bootloader is identical, so is the compiler. Nothing has changed besides th=
e kernel itself.
It is 1.5M or so, no external modules. Runtime speed after decompression se=
ems absolutely normal.
I couldn't find anything significant anywhere regarding this.


Hints would be much appreciated.


Regards,

Christian

--_000_HE1PR0701MB21210811C948CF2969F96B1790C50HE1PR0701MB2121_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p><font size=3D"2"><span style=3D"font-size:10pt;">Hi.</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt;"><br>
</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt;">I recently upgraded one=
 of Ericssons platforms from a old 3.6.x to the latest 3.16.x LTS kernel.<b=
r>
It was a smooth upgrade, besides kernel decompression taking much longer to=
 complete. From like 2 seconds to 10-12 seconds.<br>
I also tried a 4.10.z kernel with the same result.<br>
The decompression code doesn't have any significant changes as far as I can=
 see. Maybe I am looking in the wrong place?<br>
Did the ppc arch init change between 3.6.x and 3.16.x? I am thinking of cac=
he init, prefetch copy functions etc?<br>
The old Redboot loader starts the kernel with caches off. Maybe the older i=
nit re-initialized the caches before decompression?<br>
Bootloader is identical, so is the compiler. Nothing has changed besides th=
e kernel itself.<br>
It is 1.5M or so, no external modules. Runtime speed after decompression se=
ems absolutely normal.<br>
I couldn't find anything significant anywhere regarding this.<br>
</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt;"><br>
</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt;">Hints would be much app=
reciated.</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt;"><br>
</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt;">Regards,</span></font><=
/p>
<p><font size=3D"2"><span style=3D"font-size:10pt;">Christian<br>
</span></font></p>
</div>
</body>
</html>

--_000_HE1PR0701MB21210811C948CF2969F96B1790C50HE1PR0701MB2121_--
