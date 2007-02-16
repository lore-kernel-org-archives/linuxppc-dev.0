Return-Path: <dgibson@ozlabs.org>
Date: Fri, 16 Feb 2007 17:24:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [0/3] RFC: Cleanups and improvements to the zImage wrapper
Message-ID: <20070216062458.GA23008@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here is a set of three patches that make some substantial changes to
the zImage wrapper's flow of control.  These changes make things more
flexible, in order to more easily handle a wider variety of
platforms.  They also make some things clearer than previously.

I think these are fairly close to ready to merge, but they need more
testing on various platforms.  In particular, I'm not terribly whether
my changes will work correctly on old powermac platforms booting from
COFF.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
