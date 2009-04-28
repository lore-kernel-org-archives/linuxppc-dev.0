Return-Path: <tabbott@MIT.EDU>
Received: from biscayne-one-station.mit.edu (BISCAYNE-ONE-STATION.MIT.EDU
	[18.7.7.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 20DF7DDEDA
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 01:23:19 +1000 (EST)
Date: Tue, 28 Apr 2009 11:13:48 -0400 (EDT)
From: Tim Abbott <tabbott@MIT.EDU>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 11/14] powerpc: Use macros for .data.page_aligned section.
In-Reply-To: <20090429010753.851e0f59.sfr@canb.auug.org.au>
Message-ID: <alpine.DEB.1.10.0904281110350.15450@vinegar-pot.mit.edu>
References: <1240864388-26315-1-git-send-email-tabbott@mit.edu>
	<1240864388-26315-2-git-send-email-tabbott@mit.edu>
	<1240864388-26315-3-git-send-email-tabbott@mit.edu>
	<1240864388-26315-4-git-send-email-tabbott@mit.edu>
	<1240864388-26315-5-git-send-email-tabbott@mit.edu>
	<1240864388-26315-6-git-send-email-tabbott@mit.edu>
	<1240864388-26315-7-git-send-email-tabbott@mit.edu>
	<1240864388-26315-8-git-send-email-tabbott@mit.edu>
	<1240864388-26315-9-git-send-email-tabbott@mit.edu>
	<1240864388-26315-10-git-send-email-tabbott@mit.edu>
	<1240864388-26315-11-git-send-email-tabbott@mit.edu>
	<1240864388-26315-12-git-send-email-tabbott@mit.edu>
	<20090429010753.851e0f59.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Denys Vlasenko <vda.linux@googlemail.com>, Sam Ravnborg <sam@ravnborg.org>,
	Jeff Arnold <jbarnold@mit.edu>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Anders Kaseorg <andersk@mit.edu>, linuxppc-dev@ozlabs.org,
	Paul Mundt <lethal@linux-sh.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Waseem Daher <wdaher@mit.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 29 Apr 2009, Stephen Rothwell wrote:

> This moves the page_aligned section from a common part of the
> vmlinux.lds to a 32 bit only part.  Was that intentional?

No.  See my reply to this patch from last night 
<http://lkml.org/lkml/2009/4/28/16> and the revised pair of patches in 
reply to that message that replace PATCH 11/14.

	-Tim Abbott
