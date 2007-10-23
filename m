Return-Path: <dgibson@ozlabs.org>
Date: Tue, 23 Oct 2007 13:21:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: libfdt: Make fdt_string() return a const pointer
Message-ID: <20071023032126.GL31839@localhost.localdomain>
References: <20071018021042.GC24236@localhost.localdomain>
	<E1Ik0Hf-0002ws-2r@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1Ik0Hf-0002ws-2r@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 22, 2007 at 11:37:43AM -0500, Jon Loeliger wrote:
> So, like, the other day David Gibson mumbled:
> > Currently, fdt_string() returns a (non-const) char *, despite taking a
> > const void *fdt.  This is inconsistent with all the other read-only
> > functions which all return const pointers into the blob.
> > 
> > This patch fixes that.
> > 
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> 
> Applied.

But apparently not pushed out to the public tree...

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
