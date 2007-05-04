Return-Path: <dgibson@ozlabs.org>
Date: Fri, 4 May 2007 15:54:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: [0/6] Ebony support
Message-ID: <20070504055455.GA25922@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here's the latest patch series with Ebony support.  It's been updated
to apply on the current powerpc.git tree, and has a handful of other
consolidations.

I believe the powerpc specific parts of this (patches 3-6) this is now
conceptually ready to merge, although it should get some review for
silly bugs, first.  The first two patches in the series patch the
generic serial code, and I'm currently talking to akpm and rmk about
getting them, or something that accomplishes the same thing, into
mainline.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
