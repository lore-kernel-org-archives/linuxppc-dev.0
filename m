Return-Path: <wd@denx.de>
Received: from mailout02.sul.t-online.com (mailout02.sul.t-online.com
	[194.25.134.17]) by ozlabs.org (Postfix) with ESMTP id 5DE672BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Dec 2004 09:38:23 +1100 (EST)
To: "Zeitler, Nathan" <nzeitler@osii.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 13 Dec 2004 11:50:20 CST."
	<01C22B6B78D52B46BE3C38FB525617EF909AC5@osimail.osii.com>
Date: Mon, 13 Dec 2004 22:13:25 +0100
Sender: wd@denx.de
Message-Id: <20041213211330.CE496C1430@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Lite5200 and PCI1520 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <01C22B6B78D52B46BE3C38FB525617EF909AC5@osimail.osii.com> you wrote:
>
> and write to CompactFlash devices behind a PCI1520 PCI bridge on a
> custom Lite5200 board.  I am admittedly new to this process within

Now what? Is it a custom board, or a Lite5200? 

> embedded devices and could use some direction.  We're using a recent
> 2.4.25 kernel from Denx, as well as UBOOT 1.1.1 and ELDK2.1.  

U-Boot 1.1.1 is old. You better use current code (top of CVS).

ELDK 2.1 is extremely old. You better use a current version (3.1).

> I can't access anything plugged into the sockets!  PCI1520 registers
> detect a card is inserted, but I can't read and write to flash cards
> from Linux.  I checked out PCMCIA Card Services from CVS, compiled and
> ran cardmgr and it gives a seg-fault, but indicates it is watching the

What's you PCMCIA config file looking like?


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Perl already has an IDE.  It's called Unix.
                      -- Tom Christiansen in 375bd509@cs.colorado.edu
