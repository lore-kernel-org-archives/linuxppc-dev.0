Message-ID: <3CFF5CF1.8080204@linuxfoundary.com>
Date: Thu, 06 Jun 2002 09:00:33 -0400
From: Dave Strout <dstrout@linuxfoundary.com>
MIME-Version: 1.0
To: Donald White <dbwhite@asu.edu>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Can compile, now on to booting
References: <20020605191638.298B0102F2@denx.denx.de> <3CFE7197.1040408@linuxfoundary.com> <3CFEDFC1.9080603@asu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ahhh -- I was hoping that somebody would have some thoughts like that.
 Could someone send me a copy of vxhack.c ?  The link in the FAQ (
ftp://ftp.mvista.com/pub/Area51/ppc-8xx/vxhack.c  ) doesn't have
anything anymore....

thanks,
dave.


Donald White wrote:

>
> I did this once on a mpc860 board.  It involved running the uncompressed
> kernel image through vxhack.c from Dan Malek with a few fixes since the
> segments seemed to have moved around.  The VxWorks loader would then
> load the hacked image through bootp or tftp.  I also had to have one of
> the Linux bootloader files initialize a bd_t structure.  I was able to
> poke around in memory and find where the VxWorks loader was keeping the
> environment.
>
> Don


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
