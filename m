Return-Path: <jdl@freescale.com>
From: Jon Loeliger <jdl@freescale.com>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <1123064479.417492.649639846705.qpatch@concordia>
References: <1123064479.417492.649639846705.qpatch@concordia>
Content-Type: text/plain
Message-Id: <1123095705.8638.14.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Wed, 03 Aug 2005 14:01:45 -0500
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH 0/10] Cleanup iSeries msChunks handling, and lmb code.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2005-08-03 at 05:21, Michael Ellerman wrote:
> This series of patches cleans up the iSeries msChunks structure, and
> associated macros and functions.
> 
> It also removes CONFIG_MSCHUNKS from the lmb code, and eventually removes
> CONFIG_MSCHUNKS entirely.
> 
> The final patch rely's on Stephen's FW_FEATURE_ISERIES patches.
> 
> Booted on Power3, G5, Power5 LPAR and iSeries.

Excellent.  This patch, especially the LMB simplification
and removal of the physbase bits, greatly simplifies the
notion of merging LMB form 64 land and the mem_pieces.

I have previously submitted patches against the ppc32 code
that enhance the mem_pieces towards the LMB structure as well.

Given an eventual merger of the two bodies of code, I'd
like to make the merger of these two structures more complete.
I'll work towards that goal if that's a Good Idea.

Advice here?

Thanks,
jdl
