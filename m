Message-ID: <3B7830E4.2020704@humboldt.co.uk>
Date: Mon, 13 Aug 2001 20:56:20 +0100
From: Adrian Cox <adrian@humboldt.co.uk>
MIME-Version: 1.0
To: Edward Swarthout <swarthou@ibmoto.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: assorted kernel patches
References: <200108131910.f7DJAAd09710@pacific.somerset.sps.mot.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Edward Swarthout wrote:

> 3. Additional 7450 support
>    - add machine check decodes in traps.c

The current code deals with hardware errors inside the processor by
killing the user mode thread which was unlucky enough to be running at
the time. So as well as adding decodes in traps.c, you may also want to
ensure that internal error checking is enabled on 7400/10/50, and that
the machine is halted once an error is detected. I do have a patch for
this, but there wasn't a great deal of interest last time I posted it.
> 6. Add support 8245 cpu/bridge, and mpc107 bridge

The 2_4_devel tree already supports the mpc107. What did you have in mind?
--
Adrian Cox   http://www.humboldt.co.uk/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
