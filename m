Return-Path: <axboe@kernel.dk>
Received: from kernel.dk (brick.kernel.dk [87.55.233.238])
	by ozlabs.org (Postfix) with ESMTP id A3336DE01F
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 19:23:38 +1000 (EST)
Date: Wed, 24 Oct 2007 11:23:34 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] fix powerpc breakage in sg chaining code (again)
Message-ID: <20071024092334.GM14671@kernel.dk>
References: <1193173222.7733.42.camel@johannes.berg>
	<1193176034.4097.3.camel@johannes.berg>
	<20071024091446.GL14671@kernel.dk>
	<1193217742.5715.6.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1193217742.5715.6.camel@johannes.berg>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 24 2007, Johannes Berg wrote:
> On Wed, 2007-10-24 at 11:14 +0200, Jens Axboe wrote:
> 
> > I lost track - which kernel are you booting? This looks like something
> > that should be fixed, did you try 2.6.24-rc1?
> 
> No, it came out after I pulled, I was on v2.6.23-6815-g0895e91. I'll
> give it a try, but I don't think I can confirm it works before tomorrow.
> I see the build failure got fixed with commit
> 5edadbd0ae35d2daabaf6b44f2c58d67d4021ed2 too.

0895e91d60ef9bdef426d1ce14bb94bd5875870d is definitely too old, so it
will break on IDE. I'm confident that a newer kernel will solve this
issue.

-- 
Jens Axboe
