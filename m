Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1296CDDE43
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Nov 2007 11:49:38 +1100 (EST)
Message-ID: <4747751D.4060802@garzik.org>
Date: Fri, 23 Nov 2007 19:49:33 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [RFC][PATCH 0/3] OF-platform PATA driver
References: <20071123175229.GA27143@localhost.localdomain>
In-Reply-To: <20071123175229.GA27143@localhost.localdomain>
Content-Type: text/plain; charset=utf8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mundt <lethal@linux-sh.org>,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> Hi all,
> 
> Here is the PATA Platform driver using OF infrastructure.
> 
> Mostly it's just a wrapper around a bit modified pata_platform
> driver.
> 
> Patches are well split for the easier review:
> 
> First one factors out platform_device specific bits and modifies
> pata_platform to be a library-alike driver (with platform_device
> default binding).
> 
> Second patch is OF-driver itself which is using pata_platform
> "library".
> 
> Third patch is PowerPC specific, but I'm still Cc'ing linux-ide,
> just to show how we're using it.
> 
> 
> As an alternative approach we can use plain pata_platform
> driver, but I'm not sure how Linux OF bindings' ideologists will
> or will not like it.
> 
> So, these patches are strongly Request For Comments. Feel free
> to train your nitpicking skills ;-), and/or vote for the option
> you most pleased about (or suggest another?).

Seems reasonable from a libata point of view...


(pata_platform maintainer CC'd)

	Jeff
