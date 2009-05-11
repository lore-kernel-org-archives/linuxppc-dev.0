Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from www.etchedpixels.co.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C36FDDDDB6
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 05:45:55 +1000 (EST)
Date: Mon, 11 May 2009 19:44:10 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] fix sata_sil compilation on non-DMI platforms
Message-ID: <20090511194410.46641214@lxorguk.ukuu.org.uk>
In-Reply-To: <4A086A76.3090008@garzik.org>
References: <200905062009.28087.markos@codex.gr> <4A086A76.3090008@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-ide@vger.kernel.org, Konstantinos Margaritis <markos@codex.gr>,
	linuxppc-dev@ozlabs.org, Lennert Buytenhek <buytenh@wantstofly.org>,
	Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, rmk@arm.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Ideally the DMI subsystem should be provided wrappers for platforms 
> without DMI, rendering patches like this unnecessary.

Interesting question - is the PPC OpenFirmware machine information
mappable onto the DMI space ? or the various static bits of name
information in the various ARM and the like machine descriptions.

If not which bits are similar enough we could replace dmi at the high
level with an abstract interface for system/vendor/... that was ?

(
