Date: Sun, 19 Dec 1999 20:10:01 -0700 (MST)
From: Jeff Rugen <jrugen@primenet.com>
To: Cort Dougan <cort@fsmlabs.com>
cc: linuxppc-workstation@lists.linuxppc.org,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Booting 2.2.x from VGER on PReP
In-Reply-To: <19991219174953.A20409@hq.fsmlabs.com>
Message-ID: <Pine.BSI.3.96.991219200617.27759A-100000@usr06.primenet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 19 Dec 1999, Cort Dougan wrote:

> 
> Please grab the latest pre-patch for v2.2.14 (last one was pre15).  Let me
> know if you have the same trouble there.
> 

The Makefile from vger today has
VERSION = 2
PATCHLEVEL = 2
SUBLEVEL = 14
EXTRAVERSION = pre15

This version is what gave me the error I posted about (sorry, I should have
said that initially). Are there additional patches I need beyond that, or is
that what you meant?  If there are additional patches, where do I find them?
Thanks.

----------------------------------------------------------------------------
Jeff Rugen                      jrugen@primenet.com

...Had this been an actual emergency, we would have fled in terror, and you 
would not have been informed.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
