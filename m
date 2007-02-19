Return-Path: <dgibson@ozlabs.org>
Date: Mon, 19 Feb 2007 11:48:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 3/3] zImage: Cleanup and improve zImage entry point
Message-ID: <20070219004844.GB6864@localhost.localdomain>
References: <20070216062739.6DFDBDDD05@ozlabs.org>
	<45D7AA50.3090408@am.sony.com>
	<20070218072310.GB1859@localhost.localdomain>
	<17880.61080.644756.499806@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17880.61080.644756.499806@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 19, 2007 at 11:26:00AM +1100, Paul Mackerras wrote:
> David Gibson writes:
> 
> > Err... isn't the called function responsible for setting up its own
> > stack frame if necessary.  I thought all that was needed was for r1 to
> > point to some free space.
> 
> The called function stores its return address in the caller's stack
> frame.  So r1 does need to point to a stack frame.

Ah, ok.  Fixing that now.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
