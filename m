Message-ID: <38F479DA.A68E96BE@netx4.com>
Date: Wed, 12 Apr 2000 09:27:54 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: "Wohlgemuth, Jason" <jason_wohlgemuth@gilbarco.com>
CC: "'Peter Allworth'" <linsol@zeta.org.au>,
        "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Low Memory / Software Emulation Exception / Performance
References: <200004121138.HAA05150@hoover.gilbarco.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wohlgemuth, Jason wrote:


> Attached is the patch file you requested, this should bring the head.S
> distributed in mpc8xx-2.2.13 up-to-date with the dirty page fix.


It would be _really_ nice if I could get everyone to use the
MontaVista source distribution.  That has all of these patches
and then some.  This is the source I am using to bring 2.3.xx
up to date (along with patches for board specific updates).  I
believe you can start with ftp.mvista.com, then find the RPMs
in the CDK directory for the 8xx.

Through my own fault, there are too many kernel sources floating
around.  I would like to stop that.  I should finally have this
corrected in the 2.3.xx and subsequent source trees.

Thanks.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
