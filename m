Message-ID: <3D40556C.4040108@embeddededge.com>
Date: Thu, 25 Jul 2002 15:45:48 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: David Updegraff <dave@cray.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: abatron and kernel modules.
References: <200207251713.MAA00232@mint.mw.cray.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Updegraff wrote:

> We've been very happily using BDI2000 for kernel debugging on our 405GP
> on a 2.4.2 kernel with builtin abatron MMU support (via PTBASE at 0xf0).

Hmmmm.....there was a time when we screwed up the kernel PTE by moving
around some bits and not telling the folks at Abatron we did that.....
I unfortunately don't remember the kernel versions nor the BDI2000
firmware versions that match.  All I know is the latest versions of
both work together :-)

There was also a version of the 2.4.2 kernel, perhaps even a MontaVista
snapshot, where I screwed up loading the address of the pte pointer
label during initialization.  This caused the BDI2000 to go looking into
the weeds for random bits that it tried to interpret as page tables.

I know that what you are trying to do will work when all of the bits
are lined up correctly.

If you could upgrade to a newer kernel, it would really help.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
