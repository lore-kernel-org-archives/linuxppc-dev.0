Message-ID: <FD52892BD296D71183B400065BFCB6900196E22E@il02exm12.corp.mot.com>
From: Bihari Ashwin-Q3316C <Q3316C@motorola.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: DMA pool for embedded linux kernel
Date: Thu, 23 Oct 2003 09:21:53 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings,

We are in the middle of developing a chassis which will be using Embedded
Linux and during the course of configuration we've come across some
questions that would need to be answered to ensure that we make the right
system for current development and future deployment.

One of these things is the DMA pool that needs to be allocated for PCI
devices DMA between system memory and device memory (if present). I've been
trying to search but haven't found any document or anything that describes
what a reasonable size of memory should be. As we are configuring a custom
kernel, we'd like to know what the minimum is so that we don't run out of
DMA pages, and what a reasonable maximum would be so that we don't waste
memory.

The chassis we are building will be a telecom chassis running various
switch/routing applications. Any and all help and direction would be greatly
appreciated.

Regards,

----
Ashwin Bihari

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
