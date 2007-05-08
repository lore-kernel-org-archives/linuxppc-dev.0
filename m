Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 08 May 2007 16:27:26 +1000
Subject: [PATCH 0/5] This is my pending series for 2.6.22
Message-Id: <1178605646.637780.625211974455.qpush@grosgo>
Cc: Hugh Dickins <hugh@veritas.com>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mostly, it adds my slice infrastructure that I posted a few times
before, rebased for the current code, and along with it, support
for 64K pages mapping of SPE local stores on 4K kernel 

There's also a bug fix & cleanup for the segment demotion and my
modified version of Hugh Dickins patch to stop using SLAB for
PTE pages.

-DO NOT MERGE JUST YET-

I still want to torture it a bit as I just rebased it now that all of
the get_unmapped_area changes are finally upstream.

Hopefully, I'll give you an Ack tomorrow.
