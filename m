Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4983CDDDFB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Nov 2008 04:00:57 +1100 (EST)
Message-ID: <4921A2EE.6050201@freescale.com>
Date: Mon, 17 Nov 2008 10:59:26 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Joaquin Luna <Joaquin.Luna@jdsu.com>
Subject: Re: command line partition information
References: <DF6C7BC3780EE44B83430A9F756D43B608581D77@SJEXCH03.ds.jdsu.net>
In-Reply-To: <DF6C7BC3780EE44B83430A9F756D43B608581D77@SJEXCH03.ds.jdsu.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Joaquin Luna wrote:
> I do not list any partitions in my dts file, though I tried and not seen 
> any change in the behavior.  I have enabled the option in the kernel to 
> parse the partition information from the kernel command line, is there 
> something else I need to do to set up the mtdblockX devices?

Did you enable CONFIG_MTD_OF_PARTS for device-tree-based partitions?

> mtdparts=mtdparts=nand0:2m(u-boot),3M(kernel),128K(dtb),30M(jffs2),32M(mycust),90M(myfs),90M(myfs2)

Try replacing "nand0" with "ff800000.flash".

-Scott
