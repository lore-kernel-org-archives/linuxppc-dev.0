Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <885489B3B89FB6449F93E525DF78777F06453B@srvnt506.ALLOPTIC.COM>
From: "Muaddi, Cecilia" <cecilia.muaddi@alloptic.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: access memory mapped registers
Date: Thu, 9 Jan 2003 14:00:13 -0800 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

This is probably one of those silly questions again, and I seem to be having
a lot of them lately.

I will like to access some memory mapped registers through user space
applications.
Do i just use the "mmap" function calls to map the physical memory to my
user space?
My BR/OR registers are set up properly to handle the addresses, but do i
need to configure
the kernel for those memory regions?

The address I am looking at is at physical location 0x60000000 and
0x40000000.  My RAM space is mapped to
virtual address starting at 0xc0000000 (where the RAM's physical address is
from 0x0 - 0x00ffffff)

THank you very much for your help

Cecilia

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
