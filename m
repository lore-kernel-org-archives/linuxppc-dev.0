Return-Path: <dgibson@ozlabs.org>
Date: Wed, 1 Nov 2006 18:44:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [DTC][PATCH] increment default output blob version from 3 to 16
Message-ID: <20061101074430.GB8551@localhost.localdomain>
References: <20061030104859.017cb613.kim.phillips@freescale.com>
	<E1GeyPQ-0004lv-1d@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1GeyPQ-0004lv-1d@jdl.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 31, 2006 at 12:32:24PM -0600, Jon Loeliger wrote:
> So, like, the other day Kim Phillips mumbled:
> > increment default output blob version from 3 to 16
> > 
> 
> > diff --git a/dtc.c b/dtc.c
> > index 646b814..3cb94e6 100644
> > --- a/dtc.c
> > +++ b/dtc.c
> > @@ -113,7 +113,7 @@ int main(int argc, char *argv[])
> >  	int opt;
> >  	FILE *inf = NULL;
> >  	FILE *outf = NULL;
> > -	int outversion = 3;
> > +	int outversion = 0x10;
> >  	int reservenum = 1;
> >  	int boot_cpuid_phys = 0xfeedbeef;
> 
> 
> So, I am inclined to accept this change since we all pretty
> much really need version 16 for what we are doing.

Sounds good to me.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
