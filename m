From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: Brad Midgley <brad@turbolinux.com>
Subject: Re: aty128fb does not work in newer sawtooth machines
Date: Sat, 11 Mar 2000 11:54:00 -0500
Content-Type: text/plain
Cc: linuxppc-dev@lists.linuxppc.org
References: <Pine.LNX.4.20.0003110820530.30663-100000@mail.turbolinux.com>
In-Reply-To: <Pine.LNX.4.20.0003110820530.30663-100000@mail.turbolinux.com>
MIME-Version: 1.0
Message-Id: <00031111560300.08663@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Thanks for the info.  But unfortunately, my machine requires yaboot to even
boot at all.

I looked in aty128fb.c in the kernel and they hav hardwired defaults which I
can easily change but I need to know about timing info that Mac OS uses.

Do you know of any probe code or anything at all that can determine timing info
from the MacOS side of things.

>  On Sat, 11 Mar 2000, Brad Midgley wrote:
> it may be because the video driver is counting on some initialization by
> macos (bootx).
> this is the case with aty64 on the g3 laptop. video isn't right if you use
> yaboot but it's fine with bootx.


Thanks,

Kevin

--
Kevin B. Hendricks
Associate Professor of Operations and Information Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
