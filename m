Return-Path: <SRS0+0edd04f7dbccfbee95e5+1640+infradead.org+arjan@pentafluge.srs.infradead.org>
Date: Mon, 18 Feb 2008 18:40:27 -0800
From: Arjan van de Ven <arjan@infradead.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH 1/3] Fix Unlikely(x) == y
Message-ID: <20080218184027.429cf47b@laptopd505.fenrus.org>
In-Reply-To: <200802191333.53607.nickpiggin@yahoo.com.au>
References: <47B70A61.9030306@tiscali.nl>
	<20080216094226.1e8eede1@laptopd505.fenrus.org>
	<p731w7axrat.fsf@bingen.suse.de>
	<200802191333.53607.nickpiggin@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Roel Kluin <12o3l@tiscali.nl>, lkml <linux-kernel@vger.kernel.org>,
	cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
	Andi Kleen <andi@firstfloor.org>, Willy Tarreau <w@1wt.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 19 Feb 2008 13:33:53 +1100
Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> Actually one thing I don't like about gcc is that I think it still
> emits cmovs for likely/unlikely branches, which is silly (the gcc
> developers seem to be in love with that instruction). If that goes
> away, then branch hints may be even better.

only for -Os and only if the result is smaller afaik.
(cmov tends to be a performance loss most of the time so for -O2 and such it
isn't used as far as I know.. it does make for nice small code however ;-)

 


-- 
If you want to reach me at my work email, use arjan@linux.intel.com
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
