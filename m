Return-Path: <dgibson@ozlabs.org>
Date: Thu, 10 May 2007 16:04:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [0/7] RFC: Assorted arch/powerpc mm related cleanups
Message-ID: <20070510060449.GA3118@localhost.localdomain>
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

Here is a series of patches I'm working on which follow on from my
recent patches splitting up mmu.h and pgtable.h.  These are a bunch of
cleanups to the arch/powerpc mm headers and (in some cases) code.

They haven't been tested beyond compiling for a small number of
configs yet, and I wouldn't be expecting to merge them into mainline
until 2.6.23, but for anyone who's interested, here they are.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
