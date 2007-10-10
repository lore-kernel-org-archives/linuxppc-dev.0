Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 76C49DDF15
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 02:38:23 +1000 (EST)
Date: Wed, 10 Oct 2007 11:43:36 -0500
From: Olof Johansson <olof@lixom.net>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH v2] powerpc: don't enable cpu hotplug on mpic-based pseries
Message-ID: <20071010164336.GA21507@lixom.net>
References: <20071010003824.GA8477@lixom.net>
	<200710101008.l9AA8hIG084068@sullivan.realtime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200710101008.l9AA8hIG084068@sullivan.realtime.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 10, 2007 at 05:08:44AM -0500, Milton Miller wrote:
> Olof's patch searched the device-tree again, looking for an mpic.   This
> code instead checks that we found an xics the first time by checking the
> init function.

I'm glad you find the kernel so perfect that your best use of time is
to tweak the code added in a non-critical path (performance-wise) with
a new way of checking for hardware features (no other code in the kernel
checks ppc_md function pointers for that purpose).

Pseries can only have mpic or xics, so it's not like it matters if we
check for mpic or !xics, either.

But hey, any color bike shed will do, and I don't care which one Paul
chooses to merge. I will not waste more time debating this simple patch
though. :)


-Olof
