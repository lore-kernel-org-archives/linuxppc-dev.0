Return-Path: <axboe@kernel.dk>
Received: from pasmtpA.tele.dk (pasmtpa.tele.dk [80.160.77.114])
	by ozlabs.org (Postfix) with ESMTP id 01E4BDDE11
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 01:39:25 +1100 (EST)
Date: Wed, 19 Nov 2008 15:37:37 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: spinlock lockup with next-20081118 on powerpc
Message-ID: <20081119143736.GJ26308@kernel.dk>
References: <20081119093023.48895b84.sfr@canb.auug.org.au>
	<20081119091628.GT26308@kernel.dk>
	<20081119203922.0412c041.sfr@canb.auug.org.au>
	<20081119094300.GW26308@kernel.dk>
	<20081119213304.d2d21042.sfr@canb.auug.org.au>
	<20081119105833.GZ26308@kernel.dk>
	<20081120003224.8d0f481c.sfr@canb.auug.org.au>
	<20081119133408.GE26308@kernel.dk>
	<20081120013552.587f8928.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081120013552.587f8928.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 20 2008, Stephen Rothwell wrote:
> Hi Jens,
> 
> On Wed, 19 Nov 2008 14:34:09 +0100 Jens Axboe <jens.axboe@oracle.com> wrote:
> >
> > Are you removing devices or modules? We have a bug there it seems, does
> > this help?
> 
> This is early in boot (we are waiting for the root device while running
> on the initramfs) so there could well be modules being unloaded.
> 
> That patch makes the problem go away.

Excellent, since it was an apparent but, I already updated the original
patch with this hunk.

Thanks a lot for your bisection work, Stephen!

-- 
Jens Axboe
