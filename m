Message-Id: <200006052039.WAA01344@piglet.grunz.lu>
Date: Mon, 5 Jun 2000 22:39:52 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: 2940UW & 2.4.0-test-ac7 PCI probs
To: toa@pop.agri.ch
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <393BCDA8.E346B65F@pop.agri.ch>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Andreas,

On   5 Jun, this message from Andreas Tobler echoed through cyberspace:
> I try to get the 2.4.0-test1-ac7 to boot on my 7200. It fails. I have a
> 2940UW where all my disks are connected to. A 2.3.99p9 from linuxcare
> boots, but the ac7 from bk fails with the following message:
>
> Total memory = 80MB; using 512kB for hash table (at c0300000)
> Linux version 2.4.0-test1-ac7 (root@pm7200) (gcc version 2.95.3 19991030
> (prerelease/franzo)) #4 Mon Jun 5 17:14:33 CEST 2000
> PCI bus 0 controlled by bandit at f2000000
> [snip]
> PCI: Device 00:0e.0 not available because of resource collisions
> [snip]

Get either my PCI patches or Geert's patches posted here a few hours
ago. Then enable hotswap (still needed, right, Geert?), and the resource
code should fix any collisions it finds.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
