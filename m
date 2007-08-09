Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound6-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 87B2BDDE1E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Aug 2007 04:17:16 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [PATCH 1/2] Xlinx ML403 AC97 Controller Reference device driver
Date: Thu, 9 Aug 2007 11:17:11 -0700
In-Reply-To: <1186655810.7420.26.camel@localhost>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: =?iso-8859-1?Q?Joachim_F=F6rster?= <mls.JOFT@gmx.de>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20070809181713.77B24708062@mail66-cpk.bigfish.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>,
	Lorenz Kolb <lorenz.kolb@lkmail.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

=20
I second grant here... this should eventually work on microblaze, too,
so putting it drivers/ and using XILINX_DRIVERS instead of XILINX_VIRTEX
(based on the patch Wolfgang recently posted) would probably be =
preferable.

> +
> +config SND_ML403_AC97CR
> +       tristate "Xilinx ML403 AC97 Controller Reference"
> +       depends on SND && XILINX_VIRTEX

Steve
