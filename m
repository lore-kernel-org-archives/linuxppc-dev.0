Return-Path: <bwarren@qstreams.com>
Received: from smtp104.biz.mail.re2.yahoo.com (smtp104.biz.mail.re2.yahoo.com
	[206.190.52.173]) by ozlabs.org (Postfix) with SMTP id 8C23E67C09
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Aug 2006 08:16:46 +1000 (EST)
Subject: CompactFlash on PQII Pro
From: Ben Warren <bwarren@qstreams.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Wed, 23 Aug 2006 18:16:42 -0400
Message-Id: <1156371402.17977.21.camel@saruman.qstreams.net>
Mime-Version: 1.0
Reply-To: bwarren@qstreams.com
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

I have a custom board where we've hung a CompactFlash on the local bus
of an MPC8349 processor, intending to use it in 'True IDE' mode.  The
closest thing I've found in the kernel tree is
drivers/ide/ppc/ide-m8xx.c, although it's *very* possible I'm not
looking in the right place.  

I believe my chip's local bus is similar to the 8xx, so making this
driver work with my hardware doesn't seem like that big a deal.  I fully
expect to have to monkey with UPM timings among other things.  On the
other hand, this seems like something other people would have done,
maybe with one of the other PQ families like 82xx or 85xx.

Does anyone have a patch, suggestions or flames they can throw my way?

cheers,
Ben
