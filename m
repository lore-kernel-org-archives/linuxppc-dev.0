Message-ID: <39915371.424F9D9B@relog.ch>
Date: Wed, 09 Aug 2000 14:49:53 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: dri-devel@lists.sourceforge.net
CC: linuxppc-dev@lists.linuxppc.org
Subject: [ANN] DRI PPC branch
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


We have started a branch in the DRI CVS repository dedicated to getting the
DRI fully working on PPC. I have added basic information about it on the DRI
CVS web page:

http://dri.sourceforge.net/cvs.html


This is the current status of the branch:

- The r128 GL driver works on some machines (specifically on my Pismo :) with
  either one of the recent kernels from Benjamin Herrenschmidt or with one
  from the 2.4 series.
  Please share your experience with Rage128 (Pro) hardware.

- Colours are wrong, and most things don't look quite as they should yet.

- Performance isn't too exciting yet because the driver runs in PIO mode.


TODO:

- AGP GART support. Badly needed for the r128 driver

- Get the other drivers going (except i810 maybe ;).

- Thoroughly check the modifications for PowerPC (I don't know PPC assembly)


Daryll Strauss assured me that he will gladly add developers to the project
(for CVS write access) who provide sensible patches and agree to the DRI CVS
policy (basically that all development is to be done in branches).

Patches can be submitted to the Patch Manager at the DRI SourceForge Project
Page or to the dri-devel mailing list if they're not too big.


Have fun and be happy,

Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
