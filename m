Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 11 Mar 2009 14:53:24 +1100
Subject: [PATCH 0/9] powerpc: MMU cleanup and propare for new Book3-E
Message-Id: <1236743604.932194.842849421348.qpush@grosgo>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This series of patches does some ground work to make 32 and 64-bit
page table and PTE access slightly more common and to facilitate
the addition of a new MMU type (Book3-E version 2.06 and later)
for which I'd like to be able to use the same definitions for both
32 and 64-bit implementations.

There should be little actual change to the compiled code, when there
is I should have mentioned it or separated the patch, unless I missed
something, it's mostly a matter of moving things around.

Note: some of the patches were already posted separately, those
shouldn't have changed since their were last sent to the list but
I'm resending the whole lot here for consistency.
