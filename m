Message-Id: <200009211902.VAA03147@piglet.grunz.lu>
Date: Thu, 21 Sep 2000 21:02:16 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: CPU Temperature Patch
To: djosg@mgu.bath.ac.uk
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <10009201242.AA11420@mgu.bath.ac.uk> or <11420.10009201242@mgu.bath.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there,

On  20 Sep, this message from D.J. Osguthorpe echoed through cyberspace:
> Note that the intrinsic resolution of the temperature seems to be 4 degrees
> - the values printed are at the mid-point between two 4 degree multiples.

Yes, that is so by design: 5 bit A/D for a range of 0 - 128 degrees.
Found that in some paper on the Thermal Assist Unit (ref. 2 in the
appnote).

By the way, the uncalibrated sensor has an accuracy of +- 12 degrees.


Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
