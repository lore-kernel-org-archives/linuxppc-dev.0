Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Poor 8260 FCC Ethernet performance
Date: Thu, 30 May 2002 20:07:41 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFMENODHAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have successfully booted our board using an EST like configuration.
(yeah...) Then I started testing Ethernet performance and came across
something interesting.

1. Tested FTP transfers with a dumb 10T hub and got about 444.6 kBps
2. Swapped the 10T hub for a 100T switch and the performance went down to
41.7kBps!!

I do not understand what is happening. Went from an environment that was
slow and had many collisions to a much faster, no collision environment and
got majorly penalized on performance? It is almost like the error handling
helped to keep things moving. The 100T switch produced very bursty
performance where the 10T was much more consistent.

Source version:  linuxppc_2_4_devel - less than a week old
MII PHY option:  disabled in the kernel configuration

Has anyone experience this? Ideas on how to track down the problem?

BTW: Large FTP transfers work. (which was a problem with HHL 2.0) I assume
that this has to due with the thread safe page table fixes.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
