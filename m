Return-Path: <SRS0+5527751654f2e5afd62c+1639+infradead.org+arjan@pentafluge.srs.infradead.org>
Date: Mon, 18 Feb 2008 10:33:20 -0800
From: Arjan van de Ven <arjan@infradead.org>
To: Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH 1/3] Fix Unlikely(x) == y
Message-ID: <20080218103320.41cf096f@laptopd505.fenrus.org>
In-Reply-To: <26571.1203358266@turing-police.cc.vt.edu>
References: <Pine.LNX.4.64.0802181500410.13406@vixen.sonytel.be>
	<47B70A61.9030306@tiscali.nl>
	<20080216092552.325e5726@laptopd505.fenrus.org>
	<20080216173315.GU8953@1wt.eu>
	<20080216094226.1e8eede1@laptopd505.fenrus.org>
	<47B72BFE.9060302@am.sony.com>
	<20080216103927.2a02352b@laptopd505.fenrus.org>
	<1203249003.6718.24.camel@concordia>
	<20080218135609.GD21080@cs181133002.pp.htv.fi>
	<12131.1203344830@redhat.com>
	<26571.1203358266@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Adrian Bunk <bunk@kernel.org>, Roel Kluin <12o3l@tiscali.nl>,
	lkml <linux-kernel@vger.kernel.org>, Willy Tarreau <w@1wt.eu>,
	linuxppc-dev@ozlabs.org,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 18 Feb 2008 13:11:06 -0500
Valdis.Kletnieks@vt.edu wrote:

> On Mon, 18 Feb 2008 14:27:10 GMT, David Howells said:
> 
> > __builtin_expect() is useful on FRV where you _have_ to give each
> > branch and conditional branch instruction a measure of probability
> > whether the branch will be taken.
> 
> What does gcc do the 99.998% of the time we don't have
> likely/unlikely coded?

see Andi's email.
It gets the exact same hints that 95%+ of the kernels unlikely/likely get you,
because the heuristics in it are usually the same as the kernel programmers 
heuristics.


-- 
If you want to reach me at my work email, use arjan@linux.intel.com
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
