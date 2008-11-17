Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 45AFCDDE11
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Nov 2008 05:39:30 +1100 (EST)
Message-ID: <4921BA09.1030508@freescale.com>
Date: Mon, 17 Nov 2008 12:38:01 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Joaquin Luna <Joaquin.Luna@jdsu.com>
Subject: Re: command line partition information
References: <DF6C7BC3780EE44B83430A9F756D43B608581D77@SJEXCH03.ds.jdsu.net>
	<4921A2EE.6050201@freescale.com>
	<DF6C7BC3780EE44B83430A9F756D43B60858239D@SJEXCH03.ds.jdsu.net>
In-Reply-To: <DF6C7BC3780EE44B83430A9F756D43B60858239D@SJEXCH03.ds.jdsu.net>
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
> U-boot did not accept "ff800000.flash" as the MTD ID and could not load
> the kernel image with that in the command line.

Why would u-boot care what you pass to the Linux command line?

-Scott
