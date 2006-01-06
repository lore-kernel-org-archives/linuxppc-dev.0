Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 78C3D67A76
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 Jan 2006 21:08:46 +1100 (EST)
To: zengshuai@sogou.com
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 06 Jan 2006 16:23:54 +0800."
	<6251452.1136535834574.JavaMail.postfix@mx3.mail.sohu.com>
Date: Fri, 06 Jan 2006 11:08:44 +0100
Sender: wd@denx.de
Message-Id: <20060106100844.A025D354113@atlas.denx.de>
Cc: ppc <linuxppc-embedded@ozlabs.org>
Subject: Re: How to compile freescale example programs using eldk? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <6251452.1136535834574.JavaMail.postfix@mx3.mail.sohu.com> you wrote:
>
> Them aren't linux drvier but for bareboard. How can I compile them using eldk?

You do it exactly the same way like you do it with any other compiler
toolchain.

If the tools come with Makefiles and Linker scripts for GNU  gcc  and
ld  then  you are set. If not, you will have to come up with your own
build rules and linker commands.

You can check how U-Boot code (especially  the  standalone  programs)
gets  linked, but be warned, this is not exactly trivial. You have to
understand what you are doing, and how the linker works.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Just because your doctor has a name for your condition  doesn't  mean
he knows what it is.
