Return-Path: <wd@denx.de>
Received: from mailout04.sul.t-online.com (mailout04.sul.t-online.com
	[194.25.134.18]) by ozlabs.org (Postfix) with ESMTP id E3FA867ABC
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Feb 2005 00:00:31 +1100 (EST)
To: Bryan O'Donoghue <typedef@eircom.net>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 07 Feb 2005 16:54:37 GMT."
	<42079D4D.9090904@eircom.net>
Date: Tue, 08 Feb 2005 14:00:02 +0100
Sender: wd@denx.de
Message-Id: <20050208130007.31252C108D@atlas.denx.de>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Creating a configuration for my custom MPC875 board 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <42079D4D.9090904@eircom.net> Bryan O'Donoghue wrote:
>
> You'll definately need to find out what _your_ IMAP_ADDR is, that is 
> something which is almost certainly going to be unique to your own PCB.

Actually the location of the IMMR area i just a part of the  system's
memory  map, which you just make up yourself - i. e. you can chose it
pretty freely, and in many cases you just copy  te  mapping  of  some
existing, similar board.

Of course you have to understand what you  are  doing,  but  this  is
always the case, isn't it?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
To understand a program you must become  both  the  machine  and  the
program.
