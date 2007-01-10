Return-Path: <bwarren@qstreams.com>
Received: from web301.biz.mail.mud.yahoo.com (web301.biz.mail.mud.yahoo.com
	[68.142.199.177]) by ozlabs.org (Postfix) with SMTP id AB79EDDE07
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Jan 2007 09:25:53 +1100 (EST)
Date: Wed, 10 Jan 2007 14:25:51 -0800 (PST)
From: Ben Warren <bwarren@qstreams.com>
Subject: External interrupts in 2.6.19
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <783456.20220.qm@web301.biz.mail.mud.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I'm porting my board from 2.6.17 to 2.6.19 kernel, and
now external interrupts aren't working any more.  I'm
using ARCH=powerpc on an MPC8349-based custom board. 
With the old code, we called ipic_init() from board
init code with a table of IRQ senses.  In the newer
kernel, ipic_init() takes only an OF node as a
parameter.  Looking at the PIC registers, the external
IRQs are all being set to level-triggered, when they
used to be edge-triggered.

I guess I haven't been following all of the
discussions on changes to the IPIC code, and my little
brain can't figure out the right way to do this.  Can
somebody please give a quick dump of how the new
methodology is supposed to work?

thanks,
Ben   
