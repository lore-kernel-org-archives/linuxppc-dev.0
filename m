Message-ID: <3DF7C9FB.C1BB9BA5@midrivers.com>
Date: Wed, 11 Dec 2002 16:27:55 -0700
From: Mark Pilon <mpilon@midrivers.com>
Reply-To: mark.pilon@minolta-qms.com
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: kernel for 405 w/ FPU available
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've finished the initial work to support the IBM 405pm
[405 core, larger caches, FPU] and was wondering if anyone
wants it integrated into the _devel tree.

I worked out of the 2.4 _devel rsync tree (2.4.20-rc2) as I wasn't
able to get my bitkeeper snapshot to compile for walnut.

High level view of the changes:

config.in changes to set a cpu type of 405pm,

FPU unavailable exception, load_up_fpu(), giveup_fpu(),

additions to the ibm ethernet code to support the multiplexed
mal ints on the 405pm,

bits & pieces to tie it all together, and a hack or 2 which ought
to be reworked.

Missing:
no PCI, DMA or IDE support yet.

send me email if The Powers That Be want this stuff.  It has been
stress tested with a mix of fpu tasks and handling a ping flood.


Mark

--
Mark Pilon
Minolta-QMS

P.O. Box 37
325 Dawson County Road 227
Fallon, MT.  59326-0037
1-406-486-5539 (primary voice line)
1-406-853-0433 (cell)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
