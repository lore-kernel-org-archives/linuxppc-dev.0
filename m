Return-Path: <wd@denx.de>
Received: from mailout05.sul.t-online.com (mailout05.sul.t-online.com
	[194.25.134.82]) by ozlabs.org (Postfix) with ESMTP id 63FC967A46
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 Feb 2005 04:21:53 +1100 (EST)
To: Peter Asemann <peter.asemann@web.de>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 04 Feb 2005 16:26:07 +0100."
	<4203940F.2010109@web.de>
Date: Fri, 04 Feb 2005 18:21:39 +0100
Sender: wd@denx.de
Message-Id: <20050204172144.738C0C108D@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: eldk: compiling linux for custom hardware 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <4203940F.2010109@web.de> you wrote:
> I'm going to compile embedded power pc linux for a custom hardware.
> I use the Denx ELDK.
> The Linux Kernel configuration (make menuconfig) asks what machine type
> to compile Linux for.
> So I have the problem that I do not know which option to choose ("none"
> is not an option in the dialogue) and that I also do not know what

You will have to port the  Linux  kernel  for  your  hardware,  which
includes adding appropriate entries to the config menues.

> choosing one of the existing options actually changes behind the scenes.

It will most certainly result in a configuration which is  wrong  for
your board.

> I'd like a Linux to drop out that supports my MPC875 chip, works with
> the LXT 970A ethernet PHY chip and (if possible) the ISP1301
> USB-on-the-go USB chip the board has and supports a serial terminal via
> SCC4 via the RXD4/TXD4 signals.

You will have to create a port (more exactly: a configuration) of the
Linux kernel for your board.


[Note: this has nothing to do with the DENX ELDK -- your  subject  is
somewhat misleading.]

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A morsel of genuine history is a  thing  so  rare  as  to  be  always
valuable.                                          - Thomas Jefferson
