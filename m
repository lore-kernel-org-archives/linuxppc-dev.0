Return-Path: <dgibson@ozlabs.org>
Date: Tue, 20 May 2008 16:32:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>, linuxppc-dev@ozlabs.org
Subject: Re: libfdt: Seval cleanups to parameter checking
Message-ID: <20080520063258.GP22279@yookeroo.seuss>
References: <20080520062334.GO22279@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080520062334.GO22279@yookeroo.seuss>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 20, 2008 at 04:23:34PM +1000, David Gibson wrote:
> This patch makes a couple of small cleanups to parameter checking of
> libfdt functions.
> 
> 	- In several functions which take a node offset, we use an
> idiom involving fdt_next_tag() first to check that we have indeed been
> given a node offset.  This patch adds a helper function
> _fdt_check_node_offset() to encapsulate this usage of fdt_next_tag().
> - In fdt_rw.c in several places we have the expanded version of the
> RW_CHECK_HEADER() macro for no particular reason.  This patch replaces
> those instances with an invocation of the macro; that's what it's for.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Blah, sorry, ignore.  Improved version coming.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
