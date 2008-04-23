Return-Path: <littelld@verizon.net>
Received: from vms046pub.verizon.net (vms046pub.verizon.net [206.46.252.46])
	by ozlabs.org (Postfix) with ESMTP id DBC2BDDFBD
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Apr 2008 13:33:21 +1000 (EST)
Received: from [192.168.0.6] ([71.240.185.42])
	by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01
	(built Apr
	3 2006)) with ESMTPA id <0JZR00LQEDV8EQ00@vms046.mailsrvcs.net> for
	linuxppc-embedded@ozlabs.org; Tue, 22 Apr 2008 22:33:08 -0500 (CDT)
Date: Tue, 22 Apr 2008 22:33:08 -0500
From: Dave Littell <littelld@verizon.net>
Subject: AMCC PPC440EPx/sequoia stability question...
To: linuxppc-embedded@ozlabs.org,  u-boot-users@lists.sourceforge.net
Message-id: <480EADF4.2020706@verizon.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I'm working on an AMCC PPC440EPx-based platform that's similar to the
Sequoia.  The board runs pretty well, but occasionally takes exceptions
both in U-Boot and while running Linux.  The exceptions vary from
Illegal Instructions to FP Unavailable to FP Unimplemented to ITLB and
DTLB Errors, to DSI, etc., which made us believe there's a problem with
SDRAM.  Sometimes there are simple hard lockups from which even the JTAG
can't regain control.  However, the SDRAM physical/electrical and DDR
Controller configurations have been investigated in detail (and some
corrections made) with no resulting improvement in the exception behavior.

We see problems primarily at 667 MHz but have noted some issues at 533
MHz as well.  Some boards seem particularly susceptible to this while
others rarely (if ever) exhibit the problem.

At this point all possibilities are on the table and I'm looking for any
input from anyone with experience (good, bad, or whatever) with this
processor and/or designs similar to the Sequoia.


Thanks very much,
Dave
