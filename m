Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 944F3DDE08
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Sep 2007 01:19:17 +1000 (EST)
Date: Tue, 18 Sep 2007 10:17:16 -0500
From: Scott Wood <scottwood@freescale.com>
To: Andrew Liu <shengping.liu@windriver.com>
Subject: Re: Problem booting linux with device tree table
Message-ID: <20070918151716.GA788@ld0162-tx32.am.freescale.net>
References: <7B9A8FF57DBB524190E98CABF6E56F070B9298@itri.bte.mam.gov.tr>
	<46EF93D8.6050201@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46EF93D8.6050201@windriver.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Sep 18, 2007 at 05:01:12PM +0800, Andrew Liu wrote:
> Latest U-boot need a chosen node in your DTS  file,

It does not.

> So u need to add a chosen node in your DTS file.
> 
> Take mpc8272ads for example: in its DTS, has the following:
> 
>         chosen {
>                 name = "chosen";
>                 linux,platform = <0>;
>                 interrupt-controller = <&Cpm_pic>;
>         };

Please don't use that file as an example. :-)

-Scott
