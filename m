Return-Path: <dgibson@ozlabs.org>
Date: Mon, 4 Dec 2006 11:19:56 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [LIBFDT] Add .dtb files to .gitignore
Message-ID: <20061204001956.GC32722@localhost.localdomain>
References: <11650491414017-git-send-email-grant.likely@secretlab.ca>
	<1165049149754-git-send-email-grant.likely@secretlab.ca>
	<596B6F7D-9646-471C-A5E0-F3606A89B147@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <596B6F7D-9646-471C-A5E0-F3606A89B147@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Dec 02, 2006 at 10:30:59AM +0100, Segher Boessenkool wrote:
> > diff --git a/.gitignore b/.gitignore
> > index 4b147f1..42b3e35 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -3,3 +3,4 @@
> >  *.a
> >  *.so
> >  *~
> > +tests/*.dtb
> 
> You should put this in tests/.gitignore, instead.

Applied as suggested.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
