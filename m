Message-ID: <E1836A7F3557D311A14000805F9F36FC0141C6A2@usdfo011.usac.danfoss.net>
From: Hihn Jason <JasonHihn@DANFOSS.com>
To: "'Dan Malek'" <dan@embeddededge.com>
Cc: "'navinb'" <ppc4@rediffmail.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: USB working on 823..?
Date: Thu, 16 May 2002 19:08:10 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Well, the host mode is somewhat workable, BUT it is my understanding that
you have to write software for specific devices. That is to say, you will
need to have an "approved slave list", and write code to talk to each slave
specifically.

Please let me know if I am incorrect, as we are about to finish a board
layout with extra USB host chips just to do host. If we could get it working
reliably and so any USB device can be attached with the generic USB drivers,
it would be a Good Thing(tm) and very much appreciated!

Thanks for the info & correction!
I reserve the right to be wrong.
-Jason

-----Original Message-----
From: Dan Malek [mailto:dan@embeddededge.com]
Sent: Thursday, May 16, 2002 12:34 PM
To: Hihn Jason
Cc: 'navinb'; linuxppc-embedded@lists.linuxppc.org
Subject: Re: USB working on 823..?


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
