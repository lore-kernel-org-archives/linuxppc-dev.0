Return-Path: <dgibson@ozlabs.org>
Date: Thu, 1 Mar 2007 10:33:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Timur Tabi <timur@freescale.com>
Subject: Re: Time to put bootwrapper patches into powerpc.git?
Message-ID: <20070228233334.GB3048@localhost.localdomain>
References: <20070216203134.GB26099@mag.az.mvista.com>
	<45E5FB91.5090007@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45E5FB91.5090007@freescale.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 28, 2007 at 04:00:49PM -0600, Timur Tabi wrote:
> Mark A. Greer wrote:
> > There is a rather large number of patches for the bootwrapper (from
> > Scott Wood, David Gibson, others?) queued up to go into powerpc.git.
> > I think most of them are acceptable or pretty close so IMHO it would be
> > nice to have them in powerpc.git.  Especially since I have more patches
> > for the bootwrapper and I don't know what I should base them on. :)
> > 
> > Anyone agree?
> 
> Yes, I think these patches are long overdue.
> 
> Paul, do you see any reason why these patches can't become part of 2.6.21?

Well, the merge window for 2.6.21 is closed now, but I hope they can
go into 2.6.22.  My patches, at least, still need testing on 32-bit
powermac, which I haven't managed to arrange yet.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
