Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 6FE6767B77
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 19 Nov 2006 11:48:04 +1100 (EST)
To: "Lei Sun" <leisun124@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: memory corruption after MMU turned on 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 18 Nov 2006 16:53:02 EST."
	<f9a7e7a80611181353p21dce384m21f30bc9d8935a8d@mail.gmail.com>
Date: Sun, 19 Nov 2006 01:48:01 +0100
Sender: wd@denx.de
Message-Id: <20061119004801.A57B3353B9C@atlas.denx.de>
Cc: Dave Liu <r63238@freescale.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <f9a7e7a80611181353p21dce384m21f30bc9d8935a8d@mail.gmail.com> you wrote:
> I tried enable i-cache, but it looks fine, however if i enable
> d-cache, u-boot corrupted right away, debugger showed some garbage
> memory instead of valid instruction.

Did you read the U-Boot README? It explains why this cannot work.

> > > > >    The kernel hangs after uncompressing is done, further debug shows
> > > > > that it hangs right after "rfi " instruction of the turn_on_mmu:
> > > > > function in head.S

Did you read the FAQ, like
http://www.ultsol.com/faq_p305.htm ?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Everything should be made as simple as possible, but not simpler."
                                                    - Albert Einstein
