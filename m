Message-Id: <l03130307b39f217826bc@[216.67.1.236]>
In-Reply-To: <l03130308b39f11c8f40e@[209.226.106.187]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 29 Jun 1999 21:30:03 -0400
To: Eric Dorland <dorland@lords.com>
From: "Michael R. Zucca" <mrz5149@acm.org>
Subject: Re: Problems with the atyfb driver on Power Mac G3
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 8:44 PM -0400 6/29/99, Eric Dorland wrote:
>Through playing with the mclk and pll arguments (mclk:68,pll:200) I can
>reduce the amount of "pixel dancing", but when there is a lot of movement
>on the screen it is still quite noticable. I got these values from sheer
>experimenting, and could be slowing cooking my chip for all I know.

I'm experiencing the same problem on my PowerCenter 132 with my ATI VR-Pro.
I have a feeling that there is a bug in the Rage-Pro support.

I've also had trouble with the acceleration causing garbage on the screen
in 16 bit mode when I drag windows.

It's entirely possible that we don't have the memory layout quite correct
or something. To add insult to injury I also have an Adaptec Ultra SCSI PCI
card and a 4 Gig drive that Linux is booting off of. I've had some random
files show up like "?:" including the quote characters. Maybe there are
deeper PCI problems or is this just a bug in the Adaptec driver? (With a
the R5 2.2.6 kernel and a 2.3.6 custom compile).

I've been meaning to look into the code but I haven't had the time. Anybody
have some clues? My card *used* to work under 2.1.24 when I added the
support to the original driver ;-)

_______________________________________________________________________
 Michael Zucca - mrz5149@acm.org - http://www.mdc.net/~mrz5149/
 "I will choose a path that's clear. I will choose Freewill. "
  --Rush, Freewill
_______________________________________________________________________



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
