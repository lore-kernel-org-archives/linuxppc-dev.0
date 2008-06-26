Return-Path: <dgibson@ozlabs.org>
Date: Fri, 27 Jun 2008 09:47:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: dtc: Address an assortment of portability problems
Message-ID: <20080626234743.GA16169@yookeroo.seuss>
References: <20080626010349.GH308@yookeroo.seuss>
	<20080626152528.GA12256@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080626152528.GA12256@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org, Benno Rice <benno@jeamland.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 26, 2008 at 10:25:28AM -0500, Scott Wood wrote:
> On Thu, Jun 26, 2008 at 11:03:49AM +1000, David Gibson wrote:
> > 	- the endian handling functions in libfdt_env.h, based on
> > endian.h and byteswap.h are replaced with some portable open-coded
> > versions.  Unfortunately, these result in fairly crappy code when
> > compiled, but as far as I can determine there doesn't seem to be any
> > POSIX, SUS or de facto standard way of determining endianness at
> > compile time, nor standard names for byteswapping functions.
> 
> Since device-tree and network byte order happen to be the same, we could use
> ntohl/htonl.

Not for the 64-bit version.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
