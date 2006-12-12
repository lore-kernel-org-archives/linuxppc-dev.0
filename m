Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B99A467B92
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 07:49:23 +1100 (EST)
Subject: Re: [PATCH 8/15] Supporting PCI bus and base of I/O
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200612122103.41597.arnd@arndb.de>
References: <200612120338.kBC3c08S020556@toshiba.co.jp>
	<200612122103.41597.arnd@arndb.de>
Content-Type: text/plain
Date: Wed, 13 Dec 2006 07:49:14 +1100
Message-Id: <1165956554.11914.54.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-12-12 at 21:03 +0100, Arnd Bergmann wrote:
> On Tuesday 12 December 2006 04:37, Ishizaki Kou wrote:
> > This patch includes support for pci buses, base of Celleb specific
> > devices, and etc. It works on of_platform bus.
> > 
> > Signed-off-by: Kou Ishizaki <kou.ishizaki.co.jp>
> 
> The code looks good to me, I guess it could go in, except that
> I really don't like the concept of faking a PCI bus device when
> it's not actually there. I guess the EPCI part of this is
> not controversial, so it would be good if you can split that
> out into a separate patch that we can merge first.

I personally don't have a big problem with the fake PCI stuff. The
spider and USB drivers are already working out of the box pretty much
with PCI and that's exactly what we do on IBM blades (though the
illusion is maintained by the firmware in our case).

I agree that in the long run, it's better to move that to of_platform,
but I wouldn't nack the patches for that.

Ben.
