Date: Tue, 25 Jul 2000 19:28:55 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: John Grimes <jpgrimes@johngrimes.dyndns.org>
cc: Benjamin Herrenschmidt <bh40@calva.net>, daenzerm@student.ethz.ch,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Xfree86 version 4.01
In-Reply-To: <Pine.LNX.4.21.0007251134060.1469-100000@johngrimes.dyndns.org>
Message-ID: <Pine.LNX.4.10.10007251926260.31224-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Depends what proble we are talking about.
>
> I have been unable to get anything but 1280x1024 to work correctly for
> r128.  The others are deifnetely not be probed correctly but it sounds
> like I need a patch which I shall apply and will magically be better :)

Ok, can you please set the console to 1024x768 or 800x600 before starting
X, then start the X server with the default mode used? Just to sort out
whether it's a problem in the kernel aty128fb driver (which should be
setting the mode on behalf of X in the default mode case) or X itself.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
