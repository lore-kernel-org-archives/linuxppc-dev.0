Message-ID: <369645E8.1E56FCF8@jlc.net>
Date: Fri, 08 Jan 1999 12:52:41 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Marc.Pavese@hec.utah.edu
CC: linuxppc-user@lists.linuxppc.org,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pcmcia?
References: <Pine.SGI.3.96.990107172913.51198G-100000@voth4.hec.utah.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Marc Pavese wrote:

> Hi, All -
>
> Is there a tarball or rpm of the precompiled pcmcia modules...

I have built the pcmcia-cs-3.0.3 modules for the 2.1.130 kernel.
It just happened to be from one of the SRPMs I had around.
I can upload a tarball of the kernel modules when someone points
me to a server.  You will have to get the rest of the software
from another RPM.  Just load up the 2.1.125 or 127 RPM and
copy these modules into the /lib directory.

I (and others I believe) are working on the 3.0.7 version of
the pcmcia package.

I only have a pcmcia modem and flash cards, so my testing
is limited.  All I really care about it running PPP on the modem :-).
The 3.0.3 version works OK for that.


    -- Dan



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
