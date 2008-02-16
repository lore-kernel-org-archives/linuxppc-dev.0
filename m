Return-Path: <SRS0+974f8591537a7899356a+1637+infradead.org+arjan@pentafluge.srs.infradead.org>
Date: Sat, 16 Feb 2008 09:25:52 -0800
From: Arjan van de Ven <arjan@infradead.org>
To: Roel Kluin <12o3l@tiscali.nl>
Subject: Re: [PATCH 1/3] Fix Unlikely(x) == y
Message-ID: <20080216092552.325e5726@laptopd505.fenrus.org>
In-Reply-To: <47B70A61.9030306@tiscali.nl>
References: <47B70A61.9030306@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 16 Feb 2008 17:08:01 +0100
Roel Kluin <12o3l@tiscali.nl> wrote:

> The patch below was not yet tested. If it's correct as it is, please
> comment. ---
> Fix Unlikely(x) == y
> 

you found a great set of bugs..
but to be honest... I suspect it's just best to remove unlikely altogether for these cases;
unlikely() is almost a go-faster-stripes thing, and if you don't know how to use it you shouldn't
be using it... so just removing it for all wrong cases is actually the best thing to do imo.

-- 
If you want to reach me at my work email, use arjan@linux.intel.com
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
