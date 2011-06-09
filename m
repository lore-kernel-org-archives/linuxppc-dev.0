Return-Path: <B04825@freescale.com>
Received: from AM1EHSOBE004.bigfish.com (am1ehsobe004.messaging.microsoft.com
	[213.199.154.207])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 381BBB6F80
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jun 2011 06:40:27 +1000 (EST)
Message-ID: <4DF12FAD.9010101@freescale.com>
Date: Thu, 9 Jun 2011 15:40:13 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 7/7] [v5] drivers/virt: introduce Freescale hypervisor
	management driver
References: <1307646794-26374-1-git-send-email-timur@freescale.com>
	<201106092213.13755.arnd@arndb.de> <4DF12A94.6070605@freescale.com>
	<20110609203117.GB14235@kroah.com>
In-Reply-To: <20110609203117.GB14235@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Arnd Bergmann <arnd@arndb.de>, konrad.wilk@oracle.com,
	kumar.gala@freescale.com, linux-kernel@vger.kernel.org,
	cmetcalf@tilera.com, akpm@kernel.org, linux-console@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linuxppc-dev@lists.ozlabs.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greg KH wrote:
> Why is binary compatibility important?  Isn't this a brand new driver
> for a brand new system?  What userspace tools are out there in the wild
> for such a thing?

This driver (and the hypervisor it talks to, plus the apps, etc) has been in
internal development for three years.  There hasn't been a lot of effort
internally to release this software upstream until recently.

I personally have been complaining about it for quite some time, but I have no
control over our internal release process.  Even when the hardware has been
announced and available for purchase, the BSP is sometimes only available under
NDA.  Eventually, everything is publicly released, and most of the code is
pushed upstream, but it's a long and painful struggle at times.

My concern has been dealing with the headaches of bug reports from customers,
etc as they upgrade their kernel but not their apps, and then wonder why nothing
works.

But as Arnd pointed out, it really isn't as big of deal as I make it out to be.
 I can maintain compatibility internally.  I blame my allergy medicine.

-- 
Timur Tabi
Linux kernel developer at Freescale
