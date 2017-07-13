Return-Path: <srs0=wusc=6q=hotmail.com=intermediadc@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7Wl1613QzDqk6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 20:09:33 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3x7Wl15Vlnz8t8V
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 20:09:33 +1000 (AEST)
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-oln040092072054.outbound.protection.outlook.com [40.92.72.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3x7Wl03dZFz9s82
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Jul 2017 20:09:31 +1000 (AEST)
From: luigi burdo <intermediadc@hotmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>, "linuxppc-dev@ozlabs.org"
 <linuxppc-dev@ozlabs.org>
CC: "kbuild-all@01.org" <kbuild-all@01.org>
Subject: Re: issue with kernel 4.12.rc6 addnote -kernel dont build
Date: Thu, 13 Jul 2017 10:09:28 +0000
Message-ID: <AM5P194MB01322B67735B766DF228193CC8AC0@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
References: <1498652022-10417-2-git-send-email-mpe@ellerman.id.au>
 <201707021731.2m4fORfG%fengguang.wu@intel.com>
 <AM5P194MB013262D4AE4121CF72E1DDA9C8D10@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>,
 <8760f0v9ml.fsf@concordia.ellerman.id.au>
In-Reply-To: <8760f0v9ml.fsf@concordia.ellerman.id.au>
Content-Type: multipart/alternative;
 boundary="_000_AM5P194MB01322B67735B766DF228193CC8AC0AM5P194MB0132EURP_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_AM5P194MB01322B67735B766DF228193CC8AC0AM5P194MB0132EURP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi Michael,
sorry for late reply

>Did it just stop working? That code is from 2014?

exit without right kenel build  with the error that add in the log last tim=
e.


>> Host Machine BE Qoriq e5500  16GB ram
>What userspace are you running? Is it 32-bit ?

yes 32 bit OS Ubuntu Mate 16.10 , with 64 bit kernel

>>  HOSTCC  arch/powerpc/boot/addnote
   ^^^^^^
>   What compiler is that?

 gcc 6.2.0
https://launchpad.net/ubuntu/yakkety/+package/gcc-6


>Building with V=3D1 should show you.

i will check it and report.


>These warnings seem like they're correct, but that code should never
>But they're only warnings, so they shouldn't be breaking the build AFAICS.

 Can be this issue associated with a module? i have this feeling because la=
st time i have successiful
build the kernel but without some lan modules (but i cant have lan working)=
.
Thanks
Luigi


--_000_AM5P194MB01322B67735B766DF228193CC8AC0AM5P194MB0132EURP_
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
<p><br>
</p>
Hi Michael,<br>
sorry for late reply<br>
<div style=3D"color: rgb(0, 0, 0);">
<div><br>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">&gt;Did it just stop working? That code is from 20=
14?</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">exit without right kenel build &nbsp;with the erro=
r that add in the log last time.<br>
<br>
<br>
&gt;&gt; Host Machine BE Qoriq e5500&nbsp; 16GB ram<br>
&gt;What userspace are you running? Is it 32-bit ?</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">yes 32 bit OS Ubuntu Mate 16.10 , with 64 bit kern=
el</div>
<div class=3D"PlainText"><br>
&gt;&gt; &nbsp;HOSTCC&nbsp; arch/powerpc/boot/addnote<br>
&nbsp;&nbsp; ^^^^^^<br>
&gt; &nbsp; What compiler is that?</div>
<div class=3D"PlainText"><span style=3D"font-size: 10pt;"><br>
</span></div>
<div class=3D"PlainText"><span style=3D"font-size: 10pt;">&nbsp;gcc 6.2.0&n=
bsp;</span><br>
</div>
<div class=3D"PlainText"><a href=3D"https://launchpad.net/ubuntu/yakkety/&#=
43;package/gcc-6" class=3D"OWAAutoLink" id=3D"LPlnk379831" previewremoved=
=3D"true">https://launchpad.net/ubuntu/yakkety/&#43;package/gcc-6</a>&nbsp;=
&nbsp;&nbsp;<br>
<br>
<br>
&gt;Building with V=3D1 should show you.<br>
<br>
i will check it and report.<br>
<br>
<br>
&gt;These warnings seem like they're correct, but that code should never<br=
>
&gt;But they're only warnings, so they shouldn't be breaking the build AFAI=
CS.<br>
<br>
&nbsp;Can be this issue associated with a module? i have this feeling becau=
se last time i have successiful&nbsp;</div>
<div class=3D"PlainText">build the kernel but without some lan modules (but=
 i cant have lan working).</div>
<div class=3D"PlainText">Thanks&nbsp;</div>
<div class=3D"PlainText">Luigi<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_AM5P194MB01322B67735B766DF228193CC8AC0AM5P194MB0132EURP_--
