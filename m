Return-Path: <wd@denx.de>
Received: from mailout07.sul.t-online.com (mailout07.sul.t-online.com
	[194.25.134.83]) by ozlabs.org (Postfix) with ESMTP id 5910A683B4
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Sep 2005 17:58:52 +1000 (EST)
To: xiay@nari-relays.com
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 29 Sep 2005 11:56:32 +0800."
	<200509291156.AA2359564@NARI-RELAYS.COM>
Date: Thu, 29 Sep 2005 09:58:34 +0200
Sender: wd@denx.de
Message-Id: <20050929075834.7C63C353AB4@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: how to make a PCI net card work on ICECUBE ? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <200509291156.AA2359564@NARI-RELAYS.COM> you wrote:
> 
> I found out that the ICECUBE board could tftpboot via the PCI netcard if wire net to the card, but the board could not mount NFS via the card.
> 
> So i set the environment ethact to i82559#0 and saveenv , but the board still could not mount NFS via the card.During the booting-up ,there was nothing about eth1 shown .
...
> bash-2.05b# ifconfig eth1 198.87.102.218 up
> SIOCSIFADDR: No such device
> eth1: unknown interface: No such device
> eth1: unknown interface: No such device 
> 
> where did i make mistakes ?

I guess you forgot to configure the correct driver for  your  network
card into your Linux kernel.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Old programmers never die, they just branch to a new address.
