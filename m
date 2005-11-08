Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 298F1686D1
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Nov 2005 07:53:02 +1100 (EST)
To: Tom Rini <trini@kernel.crashing.org>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 08 Nov 2005 10:56:58 MST."
	<20051108175658.GO3839@smtp.west.cox.net>
Date: Tue, 08 Nov 2005 21:52:59 +0100
Sender: wd@denx.de
Message-Id: <20051108205259.A2870352B33@atlas.denx.de>
Cc: David Jander <david.jander@protonic.nl>, linuxppc-embedded@ozlabs.org
Subject: Re: fix swapping on 8xx? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20051108175658.GO3839@smtp.west.cox.net> you wrote:
>
> > Well, at least it sounds ugly together, but it is also at least conceiveable. 
> > There seem to be people who use PCMCIA for an IDE interface, so swapping may 
> > become desireable in some cases.
> 
> I think Dan might be in the camp that says a properly designed embedded
> system won't need to swap.  And when I hear about how people do try and
> swap on systems like this, I really start agreeing.  Maybe we could make
> 8xx just select SWAP=n? :)

No! David is right. There are systems out in the field  running  with
IDE  harddisks attached (either through custom hardware interfaces or
through standard PCMCIA adapters), and some of  these  actually  need
and use swap space.

Please do not remove stuff that is needed and used to work (in 2.4).

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Virtual" means never knowing where your next byte is coming from.
