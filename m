Return-Path: <dgibson@ozlabs.org>
Date: Sat, 20 Oct 2007 08:57:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH 0/4] DTC: Introduce better DTS literal support
Message-ID: <20071019225715.GA26642@localhost.localdomain>
References: <E1IivrG-00077n-O8@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1IivrG-00077n-O8@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 19, 2007 at 12:42:02PM -0500, Jon Loeliger wrote:
> Folks,
> 
> This 4 part patch series for the DTC has:
> 
>     0001-Reformat-grammar-rules-to-not-mix-language-syntax-an.patch
>     0002-Quiet-a-bogus-May-be-used-uninitialized-warning.patch
>     0003-Appease-the-printf-format-Gods-with-a-correct-typ.patch
>     0004-Begin-the-path-to-sane-literals-and-expressions.patch
> 
> The first is a pure whitespace formatting cleaning.
> The second two clean compiler warnings.
> The final one introduces a versioned DTS file with
>     support for C-like literals.

I certainly have some comments on these, but I'm busy today and won't
be able to comment in detail until Monday or so.  Please don't apply
them to mainline before then?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
