Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: David Updegraff <dave@cray.com>
Message-Id: <200207251713.MAA00232@mint.mw.cray.com>
Subject: abatron and kernel modules.
To: linuxppc-embedded@lists.linuxppc.org
Date: Thu, 25 Jul 2002 12:13:37 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi.

We've been very happily using BDI2000 for kernel debugging on our 405GP
on a 2.4.2 kernel with builtin abatron MMU support (via PTBASE at 0xf0).

But I have not figured out how to get it deal with the address space of
a loaded kernel module: it claims that the region is missing from the
page tables.  Kernel addresses are in 0xC00xxxxx ranges, and when we load
the module, 'module_list' now points to 0xC340xxxx ranges.  BDI can
dump the physical addresses of my module, but cant talk to the virual
kernel address space of the loaded module.

Is there some page table magic that goes on with module loading that
is confusing both me and the BDI?

Thanx.

--
Dave Updegraff, Cray Inc. / dave@cray.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
