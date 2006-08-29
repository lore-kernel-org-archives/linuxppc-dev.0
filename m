Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id AA08667A3F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Aug 2006 09:58:05 +1000 (EST)
To: wei.li4@elf.mcgill.ca
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Help for building linux 2.6.15 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 29 Aug 2006 17:11:38 EDT."
	<20060829171138.y9uuwvfi4gs48ws4@webmail.mcgill.ca>
Date: Wed, 30 Aug 2006 01:58:02 +0200
Sender: wd@denx.de
Message-Id: <20060829235802.21DD7352653@atlas.denx.de>
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

In message <20060829171138.y9uuwvfi4gs48ws4@webmail.mcgill.ca> you wrote:
> 
> I am working on ELDK 4.0 package with my evaluation board: A&M MPC875, 
> after configuration for my board, and do 'make zImage', I got the 
> following errors:

I cannot find any board support for this  board  in  the  2.6  kernel
trees.  Who  ported  Linux  to this hardware? Please go and ask these
guys.

>   CC      arch/ppc/syslib/m8xx_setup.o
> arch/ppc/syslib/m8xx_setup.c:56: error: 'bd_t' undeclared here (not in 
> a function)

Broken code, and/or a broken configuration, if you ask me.

> Can anyone help me? Thanks.

Which board configration are you using? And where is the board support
coming from?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Change is the essential process of all existence.
	-- Spock, "Let That Be Your Last Battlefield",
	   stardate 5730.2
