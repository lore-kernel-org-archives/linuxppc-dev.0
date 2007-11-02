Return-Path: <dgibson@ozlabs.org>
Date: Fri, 2 Nov 2007 14:58:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>, linuxppc-dev@ozlabs.org
Subject: Re: dtc: Further Makefile cleanups
Message-ID: <20071102035828.GI19839@localhost.localdomain>
References: <20071102034016.GH19839@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071102034016.GH19839@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 02, 2007 at 02:40:16PM +1100, David Gibson wrote:
> Informed by the experience attempting to embed dtc into the kernel
> tree, make further simplification of the Makefiles.  In particular
> make the Makefile.dtc and Makefile.libfdt fragments truly minimal.
> 
> This change also stops linking dtc with libfdt, which it does not
> need.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Sod.  Don't apply, I screwed this one up somewhere along the line.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
