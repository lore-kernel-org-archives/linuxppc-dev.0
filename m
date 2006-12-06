Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id CA69D67C44
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Dec 2006 04:50:41 +1100 (EST)
Subject: Re: How to use the device tree for lite5200
From: Jon Loeliger <jdl@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <528646bc0612060821u6fbb0de2o26d04ab67d705d75@mail.gmail.com>
References: <4576E8CC.6050508@grandegger.com>
	<528646bc0612060820w5be26647h2c14730856cc6ad6@mail.gmail.com>
	<528646bc0612060821u6fbb0de2o26d04ab67d705d75@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1165427351.19135.61.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Wed, 06 Dec 2006 11:49:12 -0600
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2006-12-06 at 10:21, Grant Likely wrote:
> >
> > Add the -f flag to dtc to ignore the missing /chosen node error
> >
> > Use the "-O dtb" flag to output a fdt blob
> 
> Oh, and like Kumar said, you need the -V 0x10 flag to generate the
> correct blob version.

Oh, and, -V 0x10 is the default now with a current
top-of-git DTC too.  :-)

jdl
