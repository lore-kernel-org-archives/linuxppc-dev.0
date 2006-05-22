Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id DB4CE67A2E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 May 2006 08:15:59 +1000 (EST)
To: David Woodhouse <dwmw2@infradead.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Viable PPC platform? 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 22 May 2006 22:51:13 BST."
	<1148334674.10288.30.camel@shinybook.infradead.org>
Date: Tue, 23 May 2006 00:15:56 +0200
Sender: wd@denx.de
Message-Id: <20060522221556.E60273526CA@atlas.denx.de>
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

In message <1148334674.10288.30.camel@shinybook.infradead.org> you wrote:
>
> Out of interest, how old is that JFFS2 test? If it's with the ancient
> code in the 2.4 kernel, you'll get a _lot_ of improvement by using the
> 2.6 kernel.

This was on a MPC860 system running a 2.4.25 kernel tree with  a  MTD
snapshot of Spring 2005.

> It looks like it took about 13 seconds to mount the onboard 8MiB flash.
> I can mount 512MiB of flash in 7.9 seconds with the current kernel, with
> a 400MHz AMD Geode.

The file system size was actually only 4 MiB.

But then, a 400 MHz Geode is a bit faster than a 50 MHz 8xx, probably
not only in terms of CPU performance but  also  in  terms  of  memory
bandwidth.

> There's more work going on right now to reduce the memory usage too.

Fine, thanks!

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Make it right before you make it faster.
