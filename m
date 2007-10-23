Return-Path: <axboe@kernel.dk>
Received: from kernel.dk (brick.kernel.dk [87.55.233.238])
	by ozlabs.org (Postfix) with ESMTP id 246D9DDF7E
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 04:40:27 +1000 (EST)
Date: Tue, 23 Oct 2007 20:40:21 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Use the new sg_page() helper
Message-ID: <20071023184019.GB14671@kernel.dk>
References: <1193156092-11819-1-git-send-email-Emilian.Medve@Freescale.com>
	<alpine.LFD.0.999.0710230956330.30120@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LFD.0.999.0710230956330.30120@woody.linux-foundation.org>
Cc: chris@zankel.net, grundler@parisc-linux.org, linux-kernel@vger.kernel.org,
	Emil Medve <Emilian.Medve@Freescale.com>, kyle@parisc-linux.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	anil.s.keshavamurthy@intel.com, shaohua.li@intel.com,
	linux-arm-kernel@lists.arm.linux.org.uk,
	parisc-linux@lists.parisc-linux.org, ashok.raj@intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 23 2007, Linus Torvalds wrote:
> 
> 
> On Tue, 23 Oct 2007, Emil Medve wrote:
> >
> > Fix build error messages such as this:
> 
> Some - but apparently not all - of these are already fixed in my tree, 
> through pulls from Jens. I just pushed out the result, can you resend the 
> parts that didn't already get fixed?
> 
> As is, the patch won't apply for me, since it touches many different parts 
> and some of them are fixed.

Looks like just the mmc and xtensa bits, I've merged those up.

-- 
Jens Axboe
