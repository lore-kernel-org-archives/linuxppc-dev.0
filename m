Message-Id: <4.3.2.20010709213031.00c44910@falcon.si.com>
Date: Mon, 09 Jul 2001 21:37:57 -0400
To: <linuxppc-embedded@lists.linuxppc.org>
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: SSSSlllloooowwww MPC8240
In-Reply-To: <002AB7E4.C21188@aps.anl.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Is caching enabled (both instruction and data)?  It sounds a lot like
you are running without the benefit of caches.  Another possibility is
that you are being swamped with interrupts, but I vaguely recall that
should not be a problem for the start up bogomips calculation.

gvb


At 06:57 PM 7/9/01 -0400, anj@aps.anl.gov wrote:

>Can anybody suggest why I'm seeing the following:
>
>Under Hard Hat Linux 2.0 (2.4.2 kernel) on my MVME2100 board (MPC8240 CPU
>running at 200MHz), Linux startup reports a BogoMIPS rating of 9.59.  I've
>just built and run the exact same calibration code under vxWorks, and here
>I get a rating of 133.73 BogoMIPS, which seems much more likely to be
>correct.  Linux does seem rather sluggish at running things, so I don't
>think it's problem with the calibration.  Any ideas what could be going on
>behind the scenes to slow Linux down, and how I might track it down?
>
>I wonder whether it's related to that openpic interrupt stuff in the other
>thread...
>
>TIA,
>
>- Andrew
>--
>The world is such a cheerful place when viewed from upside-down
>It makes a rise of every fall, a smile of every frown
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
