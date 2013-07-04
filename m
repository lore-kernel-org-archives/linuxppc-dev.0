Return-Path: <neorf3k@gmail.com>
Received: from mail-ea0-x22e.google.com (mail-ea0-x22e.google.com
 [IPv6:2a00:1450:4013:c01::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DB3B22C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 11:34:28 +1000 (EST)
Received: by mail-ea0-f174.google.com with SMTP id o10so438868eaj.33
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jul 2013 18:34:23 -0700 (PDT)
Received: from [192.168.0.100] (adsl-ull-197-107.41-151.net24.it.
 [151.41.107.197])
 by mx.google.com with ESMTPSA id a4sm1329321eez.0.2013.07.03.18.34.20
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Wed, 03 Jul 2013 18:34:21 -0700 (PDT)
From: neorf3k <neorf3k@gmail.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_816BF852-ABC5-4247-94B3-078F36A0CA3F"
Subject: compile custom kernel for custom board with mpc5200b
Message-Id: <165582F7-408E-4CCC-813C-54ED09855A01@gmail.com>
Date: Thu, 4 Jul 2013 03:34:19 +0200
To: linuxppc <linuxppc-dev@lists.ozlabs.org>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Apple-Mail=_816BF852-ABC5-4247-94B3-078F36A0CA3F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

Hello, i'm developing an embedded linux system on a custom mpc5200b =
board, at University.

We have  a problem with a custom version of kernel: 2.6.23 and 2.6.33. =
We can't use newer version at the moment.

We are able to compile and load the kernel on Freescale Lite5200b and on =
Custom Board.

So, we have tested ethernet on both boards.=20
On Freescale, ethernet connection is ok, just tested with ping.

But on Custom Board we are having problems:
with kernel 2.6.23 we lost 98% packet loss.=20
We have tried to disable XLB PIPELINE in: =
arch/powerpc/platforms/52xx/mpc52xx_common.c
(just commenting these lines):

/* Disable XLB pipelining */
     /* (cfr errate 292. We could do this only just before ATA PIO
         transaction and re-enable it afterwards ...) */
     //out_be32(&xlb->config, in_be32(&xlb->config) | =
MPC52xx_XLB_CFG_PLDIS);

And with this, we have 10% packet loss.

In kernel 2.6.33, we have tried the same=85 but disabling or not the =
pipeline, we have 55% packet loss.

Where could i find some solutions?

Thank you

neorf=

--Apple-Mail=_816BF852-ABC5-4247-94B3-078F36A0CA3F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=windows-1252

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dwindows-1252"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space; =
">Hello,&nbsp;i'm developing an embedded linux system on a custom =
mpc5200b board, at University.<div class=3D"page" title=3D"Page =
9"></div><div><br></div><div>We have &nbsp;a problem with a custom =
version of kernel: 2.6.23 and 2.6.33. We can't use newer version at the =
moment.</div><div><br></div><div>We are able to compile and load the =
kernel on Freescale Lite5200b and on Custom =
Board.</div><div><br></div><div>So, we have tested ethernet on both =
boards.&nbsp;</div><div>On Freescale, ethernet connection is ok, just =
tested with ping.</div><div><br></div><div>But on Custom Board we are =
having problems:</div><div>with kernel 2.6.23 we lost 98% packet =
loss.&nbsp;</div><div>We have tried to disable XLB PIPELINE =
in:&nbsp;<span style=3D"font-family: Arial; =
">arch/powerpc/platforms/52xx/mpc52xx_common.c</span></div><div><span =
style=3D"font-family: Arial; ">(just commenting these =
lines):</span></div><div><span style=3D"font-family: Arial; =
"><br></span></div><div><span style=3D"font-family: Arial; "><div>/* =
Disable XLB pipelining */</div><div>&nbsp; &nbsp; &nbsp;/* (cfr errate =
292. We could do this only just before ATA PIO</div><div>&nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp;transaction and re-enable it afterwards ...) =
*/</div><div>&nbsp; &nbsp; &nbsp;//out_be32(&amp;xlb-&gt;config, =
in_be32(&amp;xlb-&gt;config) | =
MPC52xx_XLB_CFG_PLDIS);</div><div><br></div><div>And with this, we have =
10% packet loss.</div><div><br></div><div>In kernel 2.6.33, we have =
tried the same=85 but disabling or not the pipeline, we have 55% packet =
loss.</div><div><br></div><div>Where could i find some =
solutions?</div><div><br></div><div>Thank =
you</div><div><br></div><div>neorf</div></span></div></body></html>=

--Apple-Mail=_816BF852-ABC5-4247-94B3-078F36A0CA3F--
