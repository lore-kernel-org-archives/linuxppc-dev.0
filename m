Return-Path: <shaggy@linux.vnet.ibm.com>
Date: Mon, 1 Mar 2010 16:12:55 -0300
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
Message-Id: <20100301191255.20987.84668.sendpatchset@norville.austin.ibm.com>
Subject: [RFC: PATCH 00/13] powerpc/47x: Support for 476 core
Cc: Torez Smith <torez@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These patches add support for the 476 core.  The goal is to have a single
binary that will run on both 44x and 47x, but we still have some details to
work out.  The biggest is that the L1 cache line size differs on the two
platforms, but it's currently a compile-time option.

The code was originally written by Ben Herrenschmidt and Torez Smith, but
I've been maintaining it.  I'll take responsibility for the content, but I
can't take all the credit.

The first patch is a generic bookE feature.  Patches 2-5 add base 47x
support.  Patches 6 & 7 add a platform to support the ISS simulator, and
patches 8-13 add workarounds for DD1 and DD1.1 hardware bugs.

-- 
Dave Kleikamp
IBM Linux Technology Center
