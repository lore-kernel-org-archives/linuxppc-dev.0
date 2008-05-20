Return-Path: <dgibson@ozlabs.org>
Date: Tue, 20 May 2008 11:03:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: DTC patches
Message-ID: <20080520010346.GF22279@yookeroo.seuss>
References: <E1JyAwJ-0004Fz-9A@jdl.com> <20080520002225.GC22279@yookeroo.seuss>
	<E1JyG6M-0004up-Fl@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1JyG6M-0004up-Fl@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 19, 2008 at 07:53:14PM -0500, Jon Loeliger wrote:
> > On Mon, May 19, 2008 at 02:22:31PM -0500, Jon Loeliger wrote:
> >
> > This leaves one outstanding dtc patch from me; the v0 to v1 conversion
> > program.
> 
> Ah, I wasn't sure if we wanted to include that in
> the mess or not.  There's a theory that says we've
> converted them all and don't need to do it ever again. :-)

Well, we've converted the in-kernel ones, but there are probably
people out there with other v0 files.  Nice to give them a conversion
tool too.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
