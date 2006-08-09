Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 312F5679A6
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2006 05:18:00 +1000 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: RFC: Location for Device Tree Sources? 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 09 Aug 2006 18:05:01 +0200."
	<1155139501.17187.76.camel@localhost.localdomain>
Date: Wed, 09 Aug 2006 21:17:58 +0200
Sender: wd@denx.de
Message-Id: <20060809191758.492D7353C44@atlas.denx.de>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <1155139501.17187.76.camel@localhost.localdomain> you wrote:
>
> Well, I would still like something else. For example, I'm vendor NetFoo
> selling network appliances (ADSL modems, routers, wireless APs, ...).
...
> I want my devices to have a firmware that pass a DT to the kernel. That
> DT is bolted into the firmware. In fact, it could be separate flash
> blocks (especially if the flash has some small blocks) from the actual
> firmware code but that does not really matter.
> 
> That way, I can distribute and maintain a single kernel image update
> package as part of my software update/maintainance solution.

Understood. Why not? Such a szeario has been discussed  before,  too.
Of  course  a  split set of kernel and DT images has to be supported,
too. The proposed solution was  to  extend  the  "bootm"  command  to
accept a 3rd parameter, the DT address:

	bootm <kernel_addr> <ramdisk_addr> <dt_addr>

<dt_addr> is optional, and '-' can be used when no ramdisk  is  used.
Something like that ...

> It's not _the_ only solution but it's something that I think should be
> considered.

Of course.

> Now as far as having an official repository for the .dts files of boards
> supported by the kernel, I suppose indeed that the kenrel tree is an as
> good location as anything else.

Fine. Thanks.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Microsoft Multimedia:
You have nice graphics, sound and animations when the system crashes.
