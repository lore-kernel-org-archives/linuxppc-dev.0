Return-Path: <tytso@mit.edu>
Received: from thunker.thunk.org (www.church-of-our-saviour.org [69.25.196.31])
	by ozlabs.org (Postfix) with ESMTP id 61BF4DDDD4
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 18:03:46 +1100 (EST)
Date: Thu, 20 Nov 2008 01:11:17 -0500
From: Theodore Tso <tytso@mit.edu>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] ext4: fix some s64 printing warnings
Message-ID: <20081120061117.GA8610@mit.edu>
References: <20081112111049.68c604ff.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081112111049.68c604ff.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, adilger@sun.com,
	linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 12, 2008 at 11:10:49AM +1100, Stephen Rothwell wrote:
> A powerpc ppc64_defconfig build of Linus' current tree produces these
> warnings:

Hi Stephen,

Thanks for submitting the patch!  As it turns out, a patch that was
pretty much identical to yours was submitted by Alexander Beregalov
and was merged into mainline as of 2.6.28-rc5, as commit ID ba8292e2.

Regards,

						- Ted
