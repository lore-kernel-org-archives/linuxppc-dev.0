Return-Path: <dgibson@ozlabs.org>
Date: Tue, 20 May 2008 13:02:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: dtc: Add program to convert dts files from v0 to v1
Message-ID: <20080520030235.GK22279@yookeroo.seuss>
References: <20080515063912.GA30996@yookeroo.seuss> <E1JyHVG-00058U-CA@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1JyHVG-00058U-CA@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 19, 2008 at 09:23:02PM -0500, Jon Loeliger wrote:
> > This patch adds a new utility program, convert-dtsv0, to the dtc
> > sources.  This program will convert dts files from v0 to v1,
> > preserving comments and spacing.  It also includes some heuristics to
> > guess an appropriate base to use in the v1 output (so it will use hex
> > for the contents of reg properties and decimal for clock-frequency
> > properties, for example).  They're limited and imperfect, but not
> > terrible.
> > 
> > The guts of the converter program is a modified version of the lexer
> > from dtc itself.
> > 
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> 
> Applied.
> 
> For the record, I'd like to eventually retire this program
> as well as support for /dts-v0/.

Noted.  I think having this program available will help speed up the
arrival of the day we can do that, though.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
