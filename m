From: brian.auld@adic.com
Message-ID: <995FF289C9D69747A09E42992644595405B2368A@penguin.adic.com>
To: porter@cox.net
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Kernel Preemption patch
Date: Tue, 25 Feb 2003 06:32:29 -0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I would presume others interested in the information you posted below would
have the same questions:

(1) penguinppc.org patch page??
    - I don't remember, and couldn't find when double-checking, a link
      for patches at this url.

(2) source.mvista.com (440GP mmap patch)
    - I ncftp'ed to this location, and did not find any patches that
      were for the 440, including the mmap patch you mentioned. Is
      there a README somewhere that talks about this?

      Or, is this the pub/linuxppc/bigphys_remap... patch?

-- Brian

-----Original Message-----
From: Matt Porter [mailto:porter@cox.net]
Sent: Tuesday, February 25, 2003 8:24 AM
To: Eugene Surovegin
Cc: brian.auld@adic.com; linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel Preemption patch

On Mon, Feb 24, 2003 at 02:29:18PM -0800, Eugene Surovegin wrote:
> I used George Anzinger patch (it looked less intrusive than 0(1) to me)
> with small fixes.
>
> Actually I applied 3 different patches to achieve reasonable user-mode
soft
> real-time for 440GP kernel:
>
> 1) preempt patch (from MVL)
> 2) rtsched by George Anzinger
> 3) lock-break by RML
>
> I can make a patch for 2.4.19 PPC devel tree snapshot with all those
> patches and my fixes if you want.
>
> I'm not sure whether I should post it to the list or not.

I think these things have generally wide interest.  I'm more than
willing to host them at source.mvista.com with the 440gp mmap patches
that are already there.

I suppose we should get a pointer from penguinppc.org's patch page
to this site.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
