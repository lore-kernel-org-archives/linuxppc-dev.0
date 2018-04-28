Return-Path: <naveenkumar.i@adtl.co.in>
Received: from mail.adtl.co.in (smtp3.adtl.co.in [1.23.185.116])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40XzYB043DzDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Apr 2018 15:16:13 +1000 (AEST)
Received: from adtl-ex02.adtl.local ([10.1.1.5])
 by mail.adtl.co.in  with ESMTP id w3S50uTq002835-w3S50uTs002835
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Apr 2018 10:30:56 +0530
From: Naveen Kumar I <naveenkumar.i@adtl.co.in>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Reg: MPC8360: Enabling 8 UCCs(as ethernet ports) in kernel
Date: Sat, 28 Apr 2018 05:00:56 +0000
Message-ID: <dce3de9f477f478ba0db897edcf44c7b@adtl.co.in>
Content-Type: multipart/alternative;
 boundary="_000_dce3de9f477f478ba0db897edcf44c7badtlcoin_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_dce3de9f477f478ba0db897edcf44c7badtlcoin_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

        I am working on a customized mpc8360 based board, where i am using =
all 8 UCCs as ethernet ports. Here i am facing a problem of enabling all et=
hernet ports. At a time i am able to use 5 ethernet ports only. Individuall=
y i am able to see all ports are working. But when i try to use all ports a=
t a time, i can see only 5 ethernet ports working. The 6th,7th and 8th port=
s are showing link 100Mbps full and active. But ping is failing on these(6,=
7,8) ports. Note that these 6,7,8 ports are working when i remove any of fi=
rst 3 ports among 5 ports and add them in that place. Is there any place in=
 kernel which is causing this limitation? for this i have done some searchi=
ng online and added extra SNUMs to accommodate all UCCs but not able make i=
t happen. Please help me in resolving this issue.


Thanks & Regards

Naveen

--_000_dce3de9f477f478ba0db897edcf44c7badtlcoin_
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
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<p>Hi,</p>
<p>&nbsp; &nbsp; &nbsp; &nbsp; I am working on a customized mpc8360 based b=
oard, where i am using all 8 UCCs as ethernet ports. Here i am facing a pro=
blem of enabling all ethernet ports. At a time i am able to use 5 ethernet =
ports only. Individually i am able to see all ports
 are working. But when i try to use all ports at a time, i can see only 5 e=
thernet ports working. The 6th,7th and 8th ports are showing link 100Mbps f=
ull and&nbsp;active. But ping is failing on these(6,7,8)&nbsp;ports. Note t=
hat these 6,7,8 ports are working when i remove
 any of first 3 ports among 5 ports&nbsp;and add them in that place. Is the=
re any place in kernel which is causing this limitation? for this i have do=
ne some searching online and added extra SNUMs to&nbsp;accommodate&nbsp;all=
 UCCs but not able make it happen.&nbsp;Please help
 me in resolving this issue.&nbsp;&nbsp;</p>
<p><br>
</p>
<p>Thanks &amp; Regards</p>
<p>Naveen&nbsp;</p>
</div>
</body>
</html>

--_000_dce3de9f477f478ba0db897edcf44c7badtlcoin_--
