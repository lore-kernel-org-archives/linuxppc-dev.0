Return-Path: <dgibson@ozlabs.org>
Date: Wed, 17 Oct 2007 10:34:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: DTC Updates
Message-ID: <20071017003456.GB28260@localhost.localdomain>
References: <E1IhmXN-0003CC-39@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1IhmXN-0003CC-39@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 16, 2007 at 08:32:45AM -0500, Jon Loeliger wrote:
> 
> Guys and Dolls,
> 
> I pushed out all of David's recent DTC and libfdt patches.
> I also jammed the following patch into the mix as well.
> 
> HTH,
> jdl
> 
> 
> 
> commit 9e32930ebcacfcf7cb7c1c2b8e776eb3957cf6cb
> Author: Jon Loeliger <jdl@freescale.com>
> Date:   Tue Oct 16 07:35:38 2007 -0500
> 
>     Restore warning message about bison expected output.

Heh, the removal was kind of deliberate, since I didn't think it was
actually all that much use.  But I don't really care much one way or
the other.

I really wish bison would suppress these warnings in glr-parser mode.

> 
>     It was dropped in ad9593f229362782b953da4b805df713e8468df0.
> 
>     Signed-off-by: Jon Loeliger <jdl@jdl.com>
> 
> diff --git a/Makefile b/Makefile
> index 84f0efe..d7d1af5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -207,6 +207,7 @@ clean: libfdt_clean tests_clean
> 
>  %.tab.c %.tab.h %.output: %.y
>         @$(VECHO) BISON $@
> +       @$(VECHO) ---- Expect 2 s/r and 2 r/r. ----
>         $(BISON) -d $<
> 
>  FORCE:
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
