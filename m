Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Disable semantic checks by default 
In-Reply-To: Your message of "Thu, 18 Oct 2007 17:22:30 +1000."
	<20071018072230.GA10392@localhost.localdomain>
References: <20071018072230.GA10392@localhost.localdomain> 
Date: Mon, 22 Oct 2007 11:39:01 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Ik0Iv-0002yQ-2c@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> At present, dtc makes a lot of semantic checks on the device tree by
> default, and will refuse to produce output if they fail.  This means
> people tend to need -f to force output despite failing semantic checks
> rather a lot.
> 
> This patch splits the device tree checks into structural checks (no
> bad or duplicate names or phandles) and semantic checks (everything
> else).  By default, only the structural checks are performed, and are
> fatal.  -f will force output even with structural errors (using this
> in -Idts mode would essentially always be a bad idea, but it might be
> useful in -Idtb mode for examining a malformed dtb).
> 
> Semantic checks are only performed if the new -c command line option
> is supplied, and are always warnings only.  Semantic checks will never
> be performed on a tree with structural errors.
> 
> This patch is only a stopgap before implementing proper fine-grained
> error/warning handling, but it should at least get rid of the
> far-too-frequent need for -f for the time being.
> 
> This patch removes the -f from the dtc testcases now that it's no
> longer necessary.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl
