Message-Id: <200007092056.VAA13850@hyperion.valhalla.net>
Date: Sun, 09 Jul 2000 21:56:31 +0100
Subject: Re: X still locks up
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: "Michel Dänzer" <daenzerm@student.ethz.ch>, Gwyn Judd <b.judd@xtra.co.nz>
CC: linuxppc developers list <linuxppc-dev@lists.linuxppc.org>
Mime-version: 1.0
Content-type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sun, Jul 9, 2000, 20:24 Michel Dänzer wrote:
> Gwyn Judd wrote:
>
>> When I tried to play an mp3 through xmms X locked up completely although I
>> was able to change VT's, however I was unable to kill X or reboot properly.

another thought - Which version of XMMS ?

> Strange, if X hangs you actually shouldn't be able to switch VT...

True...

More info.

I observed an effect (*before* doing the back-port) that when I reduced the
buffer size to minimum X ran like treacle (ATI Mach64 + G3 shouldn't be)...
could (just) possibly look a little like a lock-up if the machine was
slower...

Update:

I just used the back-ported drivers to run Benno Senoner's latency test code
- which simultaneously stresses various parts of the system whilst playing
sound...  The includes running x11perf.

No problems here... (the results are not so good but that's another
story)...

I might leave Benno's test running overnight to see if I can get the 'lock'
effect - but I've been hammering this system (with complies, debugs, find /,
netscape etc. etc.) and can't replicate the problem.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
