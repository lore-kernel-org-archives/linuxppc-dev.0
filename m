Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Mon, 14 Oct 2002 11:46:01 -0500 (CDT)
From: Bret Indrelee <Bret.Indrelee@qlogic.com>
Reply-To: Bret Indrelee <Bret.Indrelee@qlogic.com>
To: Linux PPC Embedded mailing list <linuxppc-embedded@lists.linuxppc.org>
Subject: Binary Compatibility of various flavors of PPC
Message-ID: <Pine.LNX.4.33.0210141138290.24959-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We are trying to wade our way through the various processor choices and
options available for PPC on Linux.

One of our requirements is to be able to run the same binary image across
a range of systems. The image can not change just because the processor
does.

We are currently looking at the 405GPX, 8250, 8245, and PowerQUIC III.

One thing we haven't been able to figure out is if the same PPC Linux
system binary (including OS) can be configured to boot on any of these
processors. It looks like the MMU changes when you go to Book E
architechure (no BAT), but I'm not sure what some of the other differences
might be.


Can someone please tell me if it is possible to have an OS image that
can boot any of the various PPC processors and adapt based on which
processor model it is?

Thanks,

-Bret

--
Bret Indrelee                 QLogic Corporation
Bret.Indrelee@qlogic.com      6321 Bury Driver, St 13, Eden Prairie, MN 55346


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
