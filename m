Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 9796B6886D
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Dec 2005 07:35:18 +1100 (EST)
To: Alan Carvalho <alancarbr@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 05 Dec 2005 17:30:22 -0200."
	<dc70db7d0512051130s498f7d5fk42a0f4886c006efd@mail.gmail.com>
Date: Mon, 05 Dec 2005 21:35:15 +0100
Sender: wd@denx.de
Message-Id: <20051205203515.51D4C353F5E@atlas.denx.de>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Video Card to Lite5200 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Alan,

in message <dc70db7d0512051130s498f7d5fk42a0f4886c006efd@mail.gmail.com> you wrote:
>
> I am just looking for a cheaper video card to use with Lite5200 board.
> CoralP is very expansive, then I will use ATI Rage Mobility.

Make sure that you don't need to run any (x86) BIOS code on your card
to initialize it. This is the main issue with most graphics cards.

> Well, my video card is not ATI Rage Mobility M1 EVA, it has not 723
> regulator, it use MTD3302 as regulator, do you know if I need change
> something on the Lite5200's PCI slot to it work with this video card?

If your card is a true 3.3V PCI card it should be at  least  possible
to  attach  and  test it. Chances are that it does not work (at least
not without some amount of work).

> My Lite5200 is Version 2.0, and Freescale connected some wire (small cables)
> to PCI slot, maybe to fix some PCI problems.

You probably want to ask FS about this.

> I am using linux kernel 2.6.14, downloaded from denx's web site. Linux is

Note that the 5200 code in the kernel is work in progress. I  do  not
cleaim  that it does work in any way. If you want stable code use our
2.4.25 kernel instead.

> running fine in this board, but until now I am using only serial console.
> Now I want use a video card with it.

Well, if your time is worth anything you  might  find  out  that  the
CoralP  is the cheaper solution - or using a graphics controller that
can be attached directly to the bus.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
In general, they do what you want, unless you want consistency.
                                    - Larry Wall in the perl man page
