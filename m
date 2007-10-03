Return-Path: <dgibson@ozlabs.org>
Date: Wed, 3 Oct 2007 15:29:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 8/15] bootwrapper: convert flatdevtree to version 16
Message-ID: <20071003052938.GC18978@localhost.localdomain>
References: <boot-8-00.miltonm@bga.com> <boot-8-08.miltonm@bga.com>
	<20070924033612.GI8058@localhost.localdomain>
	<5e71423247aef068d82b84166102fd7d@bga.com>
	<20070925034616.GB2525@localhost.localdomain>
	<69f1ad37eec293a4c4616d04c8400ca4@bga.com>
	<20070927024535.GC14030@localhost.localdomain>
	<41180fced14196db80f261d2ac1909e0@bga.com>
	<20070928024052.GA18840@localhost.localdomain>
	<61d44782a59ff62300416fbed26236f0@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <61d44782a59ff62300416fbed26236f0@bga.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 28, 2007 at 10:16:51AM -0500, Milton Miller wrote:
[snip]
> Actually, there is another approach: put this converter in kexec's  
> purgatory or even the kexec program.  It can then run conditionally  
> under command line flags to keep compatibility with the old kernels.   
> If and when its is decided to only support >=v16 in kexec-tools it can  
> be removed and we don't have this interim support code in the kernel  
> forever (I'll handle my other usage out of tree).

Hurrah!  Well, please do that then.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
