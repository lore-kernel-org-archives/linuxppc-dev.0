Return-Path: <JayasriS@aaesys.com>
Received: from AAE-Exch.aaesys.com (mail.aaesys.com [67.131.247.41])
	by ozlabs.org (Postfix) with ESMTP id 16534DE46E
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 07:58:55 +1000 (EST)
From: Jayasri Sangu <JayasriS@aaesys.com>
To: "'linuxppc-dev@ozlabs.org'" <linuxppc-dev@ozlabs.org>
Date: Tue, 19 Aug 2008 14:53:22 -0700
Subject: DMA Cache problem on PPC8248.
Message-ID: <2DE723F44CAFD24A9B6BF606813F010C0945BE21@aae-exch>
Content-Type: multipart/alternative;
	boundary="_000_2DE723F44CAFD24A9B6BF606813F010C0945BE21aaeexch_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--_000_2DE723F44CAFD24A9B6BF606813F010C0945BE21aaeexch_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,

   We are using PPC8248 provided by freescale and the kernel  2.6.10. I bel=
ieve we have cache problem.

  We are allocating DMA buffers in our driver. If we increase the DMA buffe=
r size the board hangs/halts(when try to load more applications).

  If we reduce the DMA buffer size, then we can run all our applications.

   Is there any way I can get around this problem.


Thanks
Jayasri





--_000_2DE723F44CAFD24A9B6BF606813F010C0945BE21aaeexch_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Calibri, sans-serif" size=3D"2">
<div>Hi All,</div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp; We are using PPC8248 provided by freescale and the kernel=
&nbsp; 2.6.10. I believe we have cache problem. </div>
<div>&nbsp;</div>
<div>&nbsp; We are allocating DMA buffers in our driver. If we increase the=
 DMA buffer size the board hangs/halts(when try to load more applications).=
 </div>
<div>&nbsp;</div>
<div>&nbsp; If we reduce the DMA buffer size, then we can run all our appli=
cations. </div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp; Is there any way I can get around this problem.</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Thanks</div>
<div>Jayasri</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
</font>
</body>
</html>

--_000_2DE723F44CAFD24A9B6BF606813F010C0945BE21aaeexch_--
