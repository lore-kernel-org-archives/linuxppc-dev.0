Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id A88D767A39
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Apr 2006 10:12:27 +1000 (EST)
To: "Jessica Chen" <jessicac@tccomm.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Port Linux w/ mbxboot to PPCBoot system 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 14 Apr 2006 16:56:44 PDT."
	<002701c6601f$15b27f30$9afea8c0@tcdomain.com>
Date: Sat, 15 Apr 2006 02:12:24 +0200
Sender: wd@denx.de
Message-Id: <20060415001224.D1551353A56@atlas.denx.de>
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

Dear Jessica,

in message <002701c6601f$15b27f30$9afea8c0@tcdomain.com> you wrote:
> 
>      I am new to embedded system, I am studying ppcboot-1.1.5 and linux
> kernel-2.4.4 that comes with an mpc852 base board, we want to modify it in

Both PPCBoot and Linux 2.4.4 are *hoplessly* obsolete. It may  be  ok
to study this to understand the workings, but please don't even dream
of using it for any current work.

> the future.  In the build process, they use the zImage.initrd
> (arch/ppc/mbxboot/zvmlinux.initrd) instead of the raw Linux kernel image

Somebody didn't know what he was doing, it seems.

> since ppcboot is already running, what happens when I boot the kernel that
> has old boot loader code in arch/ppc/mbxboot?  Will some parameters be
> overwritten?  If not, why?

The Linux bootstrap loader code (arch/ppc/mbxboot)  will  ignore  the
parameteres  passed  by  U-Boot,  will set up is own (hardwired), and
duplicate some of the things that PPCboot did or would do.

>      I am very tempted to follow the README to re-build the kernel with only
> vmlinux.gz and port it, but I don't want to create any un-recoverable
> results.  So I am here to seek advice, maybe this is something obvious to
> many people.

Don't change anything. Look at it, then drop it. Start using  current
code, i. e. a recent version of U-Boot and a recent Linux kernel.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Good morning. This is the telephone company. Due  to  repairs,  we're
giving  you  advance notice that your service will be cut off indefi-
nitely at ten o'clock. That's two minutes from now.
