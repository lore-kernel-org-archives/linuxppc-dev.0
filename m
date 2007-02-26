Return-Path: <SRS0+d6cead0195db3fcd630e+1282+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AFAFFDDE49
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Feb 2007 07:57:22 +1100 (EST)
Subject: Re: Make sure we populate the initroot filesystem late enough
From: David Woodhouse <dwmw2@infradead.org>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <35684e789e5c2447eab393c8946efcb9@bga.com>
References: <1172462466.3971.46.camel@shinybook.infradead.org>
	<35684e789e5c2447eab393c8946efcb9@bga.com>
Content-Type: text/plain
Date: Mon, 26 Feb 2007 15:57:48 -0500
Message-Id: <1172523468.3560.2.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, torvalds@linux-foundation.org,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-02-26 at 10:44 -0600, Milton Miller wrote:
> Any chance you are using one of the unusal code paths, like the 
> bootloader moving the initrd or using a kernel crash region?

I'm doing nothing special. And I'm less sure now about the trigger. I
built a Fedora 7 test 2 install tree with the patch reverted, and
managed to boot and install.... but now when I boot the _same_ machine
with the same CD, it fails. 

Now I'm starting to wonder if it's something the firmware sets up to DMA
to a certain region of memory, which makes it non-deterministic. And the
other things we're blaming are only making a difference because they
change the layout of what we have in memory.

-- 
dwmw2
