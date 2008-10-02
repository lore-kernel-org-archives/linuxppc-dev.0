Return-Path: <dgibson@ozlabs.org>
Date: Thu, 2 Oct 2008 10:52:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Niklaus Giger <niklaus.giger@member.fsf.org>
Subject: Re: [PATCH] Added preliminary support for Netstal HCU4 board
Message-ID: <20081002005208.GE25598@yookeroo.seuss>
References: <200810011947.16543.niklaus.giger@member.fsf.org>
	<20081001180835.GA7601@yoda.jdub.homelinux.org>
	<200810020014.20414.niklaus.giger@member.fsf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200810020014.20414.niklaus.giger@member.fsf.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 02, 2008 at 12:14:19AM +0200, Niklaus Giger wrote:
> Am Mittwoch 01 Oktober 2008 20.08:35 schrieb Josh Boyer:
> > On Wed, Oct 01, 2008 at 07:47:16PM +0200, Niklaus Giger wrote:
> > >Adds preliminary support for a HCU4 PPC405GPr based board from
> > >Netstal Maschinen AG.
> > >
> > >For the last 3 years I have been the only user running Linux on this
> > > board, but it served me well as testbed for the xenomai realtime
> > > extension to the Linux kernel.
> >
> > Overall, really nice for a first submission.
> One never has a second chance to make a first imrpession.
> 
> It was easy to make the needed changes (except changing ibm -> amcc, see 
> below). The dtc does the conversion from the old to the new format dts-v1 
> without a hitch. Calling "dtc -I dts -O dts hcu5.dts.old >hcu5.dts.new"l

That will work, but will lose comments, references, and other
formatting, because it essentially compiles then decompiles the tree.
You probably don't want to do that.  There's also an explicit
conversion program, convert-dtsv0, which will preserve that
not-significant-to-output, but useful for the reader information.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
