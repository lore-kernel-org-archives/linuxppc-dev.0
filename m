Message-ID: <3CE3DF91.6030008@embeddededge.com>
Date: Thu, 16 May 2002 12:34:25 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Hihn Jason <JasonHihn@DANFOSS.com>
Cc: "'navinb'" <ppc4@rediffmail.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: USB working on 823..?
References: <E1836A7F3557D311A14000805F9F36FC0141C6A0@usdfo011.usac.danfoss.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hihn Jason wrote:

> Well, at least with the 832e, you can't.

With the 823e, you _can_ :-)


> The 823e was made for Kodak in the dawn of USB,

You are getting your 823 and 823e mixed up.  The original 823 was produced
as you said, and to only support a slave USB interface.  In limited cases,
the 823 could support a host interface, but it was tricky with lots of
software timing issues to solve.

The 823e, and newer 850 (Rev. B) processors have some modifications to
better allow USB host support.  These require some external support (looping
a clock back to the I/O pin) and the downloading of a microcode patch for
properly generating SOF timing.

The 823e has other nice features, like bigger caches and more control over
the LCD DMA.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
