Return-Path: <wd@denx.de>
Received: from mailout07.sul.t-online.com (mailout07.sul.t-online.com
	[194.25.134.83]) by ozlabs.org (Postfix) with ESMTP id 816232BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Jan 2005 01:46:42 +1100 (EST)
To: Jens-Peter.Oswald@kayser-threde.de
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 13 Jan 2005 13:37:12 +0100."
	<1D40077EC04042479FDA552D718E051B010D7528@ktms3.net.local>
Date: Thu, 13 Jan 2005 15:46:05 +0100
Sender: wd@denx.de
Message-Id: <20050113144610.7E0A9C1466@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: TQM860L hangs after soft reboot 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <1D40077EC04042479FDA552D718E051B010D7528@ktms3.net.local> you wrote:
> 
> After a soft reset (from linux or bootloader u-boot) the board hangs. 

I don't know which Linux kernel you're running, but U-Boot triggers a
checkstop reset of the CPU to reboot the system.  If  this  does  not
restart the board, then there is a hardware problem.

> I assume it might be a forgotten pullup- or pull down in our custom
> board.
> 
> Any hints which pins I must check?

You should probably contact TQ Support with such a question. I  doubt
that this is a topic for this mailing list. Try asking Andreas Widder, 
08153-9308-235, <Andreas.Widder@tqc.de>

> By the way, how does linux handle a soft reset?

See function m8xx_restart() in "arch/ppc/kernel/m8xx_setup.c"; in our
linuxppc_2_4_devel tree the  same  mechanism  as  in  U-Boot  (i.  e.
checkstop reset) is used.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The best things in life are for a fee.
