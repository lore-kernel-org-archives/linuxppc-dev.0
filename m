Return-Path: <dgibson@ozlabs.org>
Date: Thu, 10 Jan 2008 14:56:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/3] Return a non-zero exit code if an error occurs
	during dts parsing.
Message-ID: <20080110035609.GL17816@localhost.localdomain>
References: <20080103234333.GC8441@ld0162-tx32.am.freescale.net>
	<20080104043033.GD4326@localhost.localdomain>
	<20080106225509.GC8239@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080106225509.GC8239@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jan 06, 2008 at 04:55:09PM -0600, Scott Wood wrote:
> On Fri, Jan 04, 2008 at 03:30:33PM +1100, David Gibson wrote:
> > This is unequivocally wrong.  boot_info should have information about
> > the contents of the blob, not state information like the error.
> 
> "This blob is invalid" *is* information about the contents of the blob.
> 
> > If you're going to use an ugly global, then use it everywhere.
> 
> Why go out of our way to make the code even less library-able/thread-safe?

It doesn't make it any less thread-safe.  A global variable used some
places is just as bad as a global variable used everywhere from that
point of view, and is more complicated.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
