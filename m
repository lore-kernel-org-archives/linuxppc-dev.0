Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 2B0431007D6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2011 03:28:07 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 29404-10 for <linuxppc-dev@lists.ozlabs.org>;
 Wed, 14 Dec 2011 16:28:03 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: ARM + TI DSP device tree repesentation
Date: Wed, 14 Dec 2011 16:27:46 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AF13@saturn3.aculab.com>
In-Reply-To: <ACB6D0C0104CFF42A45A5D82A0DD4F3D014365@039-SN2MPN1-013.039d.mgd.msft.net>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Aggrwal Poonam-B10812" <B10812@freescale.com>,
 <linuxppc-dev@lists.ozlabs.org>
Cc: Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> I am trying to locate the device tree for OMAP platform which=20
> has ARM and TI DSP core.
>=20
> The background is that we are trying to understand how such=20
> SOCs with dissimilar cores are represented in linux.

Most likely linux runs on the ARM, and the DSP processor
is loaded with specific code to perform certain functions.

As such the DSP is probably a 'peripheral' not a cpu.

	David
