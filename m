From: bob@kunk.jriver.com
Message-ID: <20010316173403.8304.qmail@kunk.jriver.com>
Subject: Re: Multiple PCI buses in 2.4?
To: mlan@cpu.lu
Date: Fri, 16 Mar 2001 11:34:03 -0600 (CST)
Cc: bob@kunk.jriver.com, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200103152158.WAA00851@piglet.grunz.lu> from "Michel Lanners" at Mar 15, 2001 10:58:05 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


User Michel Lanners says:

> Multiple PCI busses should work just fine, with one exception: the
> chaos-based second bus in the 7x00/8x00 machines.

Ahh ok I get it now.

> Now this is my fault, so to speak ;-) I've modified planb to use the PCI
> device structure, but since that isn't available in the current 2.4
> kernels, you're out of luck.
>
> However, I'm working right now on patches tha fix the detection of the
> chaos bus and its devices; so that this problem should be solved soon.

The patches work great so far! I haven't had a chance to try the video
input with a real signal yet, I lent out my camera, but it puts out
nice black screen with xawtv and the dmesgs are all reassuring.

Thanks,
Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
