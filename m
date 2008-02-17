Return-Path: <sheflin@newagemicro.com>
Received: from server196.onecontrol.com (ip-66-129-110-196.name-host.com
	[66.129.110.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D8136DDEED
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 18 Feb 2008 02:27:11 +1100 (EST)
Date: Sun, 17 Feb 2008 10:27:22 -0500
To: linuxppc-embedded@ozlabs.org,Josh Boyer <jwboyer@gmail.com>
From: Steve Heflin <sheflin@newagemicro.com>
Subject: Re: Sequoia NAND - others missing?
In-Reply-To: <20080217071851.0edbf07f@vader.jdub.homelinux.org>
References: <20080217113932.02EBDDE127@ozlabs.org>
	<20080217071851.0edbf07f@vader.jdub.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Message-Id: <20080217152711.D8136DDEED@ozlabs.org>
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

Are there other devices (beside the NAND Flash Controller) that exist 
on the AMCC-440EPx chip and are not supported by the current 
Linux-2.6.25 ARCH=powerpc?

thanks for your help,
Steve

At 08:18 AM 2/17/2008, Josh Boyer wrote:
>On Sun, 17 Feb 2008 06:39:43 -0500
>Steve Heflin <sheflin@newagemicro.com> wrote:
>
> > I don't see where the new powerpc architecture and drivers/mtd/nand
> > contains support for the NAND chip on the Sequoia platform.  We have
>
>It's not.
>
> > Is the Sequoia's NAND Flash Controller supported in the current 
> Linux-2.6.25?
>
>No.
>
>There are a couple different patches floating around for it, all of
>which need work.  The driver is drivers/mtd/nand/ndfc.c and work needs
>to be done to parse a device tree and present the proper platform
>devices so that driver will work.  Stefan has something like this
>somewhere, I've just been lax in getting it into my tree.
>
>Too late for .25, but I have 4 boards that use this now so I'll be a
>bit more interested in getting it into .26.
>
>josh
