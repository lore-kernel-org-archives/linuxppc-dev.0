Date: Tue, 15 Dec 1998 09:46:32 -0700 (MST)
From: Jeff Rugen <jrugen@primenet.com>
To: David Ray <daver@idiom.com>
cc: linux-pmac@samba.anu.edu.au,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: QuickCam
In-Reply-To: <v02140b06b299f1f9865f@[209.157.72.95]>
Message-ID: <Pine.BSI.3.96.981215094023.4080A-100000@usr04.primenet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



The PC version of the Quickcam uses the parallel and keyboard ports, but
only uses the keyboard port for power.  When I was running 2.0.30 on a
Motorola PowerStack, I had one of the quickcam drivers built and working
(one that works as a module, not the stand-alone applications).  Since then,
I've moved the printer to my PowerStack's paralell port so haven't tried to
see if the 2.1.x drivers work (they didn't around 2.1.60, but part of the
problem was a lack of software that used the new interface -- the ioctls
have changed from 2.0.x drivers to the ones in the kernel... at least I
think that was the problem).

To work with a Mac, you'll have to modify the code that assumes a parallel
port to work with the Mac serial interface.  I assume there's source code
out there that interfaces with a Mac quickcam, but I've never looked at it.
Connectix used to have a web page listing third party software
(shareware/freeware/etc) but since they sold the Quickcams to Logitech, I
don't know where you'd find it.

----------------------------------------------------------------------------
Jeff Rugen                      jrugen@primenet.com

...Had this been an actual emergency, we would have fled in terror, and you 
would not have been informed.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
