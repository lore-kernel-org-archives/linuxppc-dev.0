Return-Path: <markc@mail.com>
Received: from relay03.roc.ny.frontiernet.net (relay03.roc.ny.frontiernet.net
	[66.133.182.166]) by ozlabs.org (Postfix) with ESMTP id 42722683DA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Sep 2005 23:21:05 +1000 (EST)
Message-ID: <007701c5c4f4$c7e539c0$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Fend, Matthias" <mfend@harris.com>,
	<linuxppc-embedded@ozlabs.org>
References: <8D4C69676E66D511A1CB00508BBBB192052D42EF@ranmx1.cs.myharris.net>
Date: Thu, 29 Sep 2005 08:52:08 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: mpc8xx and LCD
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

mpc8xx and LCD>hello,
>We want to use mpc860/855 with a 320x240 graphic lcd module.
>Now there are many possibilities to interface such a module, but I guess
this is not the first time
>someone will need a LCD display. So I'm trying to find out the most common
way to implement the
>desired functionality.
>At the moment I think we should use a lcd controller from Epson (S1D13700
or S1D13305) since they are
>working on Linux framebuffer device driver for it. But I'm not sure how to
design the hardware interface ... all
>the LCD modules I found provide only a reduced number of port pins so that
the controller only can be used
>in indirect-mode, so I'm not sure whether to connect the module directly to
the CPUs bus or use some
>GPIO pins for this...
>Has anybody else implemented a LCD into a mpc8xx (not 823) board
successfully ?
>Are there some good resources somewhere in the web about this topic ?
>thanks for your recommendations,
> mattthias

Can you send a couple of links to the modules you are considering?

Mark Chambers
