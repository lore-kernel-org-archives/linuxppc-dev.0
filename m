Return-Path: <rubini@mail.gnudd.com>
Received: from mail.gnudd.com (adsl-203-134.38-151.net24.it [151.38.134.203])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BA82468879
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Dec 2005 07:48:57 +1100 (EST)
Date: Mon, 5 Dec 2005 21:39:41 +0100
From: Alessandro Rubini <rubini@gnudd.com>
To: wd@denx.de
Message-ID: <20051205203941.GA16695@mail.gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: rubini@ar.linux.it
In-Reply-To: <20051205203515.51D4C353F5E@atlas.denx.de>
References: <20051205203515.51D4C353F5E@atlas.denx.de> 
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Video Card to Lite5200 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> Note that the 5200 code in the kernel is work in progress. I  do  not
> cleaim  that it does work in any way. If you want stable code use our
> 2.4.25 kernel instead.

FWIW, I have your 2.6.14 happily running on the lite5200, with PCI,
IDE (no DMA though) and flash.

I can publish the patches, if anyone is interested. Until now I didn't,
as Sylvain's work is considered the official one (but it didn't have
IDE last time I checked -- and I don't have bitkeeper to pull it).

/alessandro
