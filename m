Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id B0EE667B78
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2006 00:03:41 +1000 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: RFC: Location for Device Tree Sources? 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 09 Aug 2006 13:18:29 +0200."
	<1155122309.4040.94.camel@localhost.localdomain>
Date: Wed, 09 Aug 2006 16:03:36 +0200
Sender: wd@denx.de
Message-Id: <20060809140336.9E3C93535D4@atlas.denx.de>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <1155122309.4040.94.camel@localhost.localdomain> you wrote:
>
> > Where should we place the sources for the OF Flat Device
> > Tree source files?  They used to be in U-Boot, but that
> > isn't happening any more.
> 
> Why ? While having device-tree's in zImages is good to handle firmwares
> that can't pass them, I still think that the proper thing to do is to
> have the firmware provide the DT to the kernel. Did Denk decide once for
> all against having DTs passed by uboot at all ? In which case, it's
> probably time to consider a fork...

Ben, you are mixing two things here.

I have nothing against U-Boot  passing  the  DT  to  the  kernel.  On
contrary,  if  DT's  are  used, than I think this is how it should be
done.

It's just that I think that the DT *sources* should not  be  part  of
the  U-Boot  soutrce  tree, and that the DT should be in fact part of
the kernel images that gets booted by U-Boot.

This has been discussed before (see archives), and the agreement  (?)
was  to  use  U-Boot's multifile image format for this purpose, where
you can combine a Linux kenrel image with a DT image  into  one  file
bootable by U-Boot.

Jon's question was where the source code of the DT should be placed.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
What is mind?  No matter.  What is matter?  Never mind.
                                      -- Thomas Hewitt Key, 1799-1875
