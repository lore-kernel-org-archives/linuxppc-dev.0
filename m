Message-ID: <39998B4F.2AD2E17E@student.ethz.ch>
Date: Tue, 15 Aug 2000 20:26:22 +0200
From: Michel D	nzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: "Kevin M. Myer" <kevin_myer@iu13.k12.pa.us>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Control fb problem on 8500
References: <Pine.LNX.4.21.0008151339190.734-100000@pegmatite.iu13.k12.pa.us>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Kevin M. Myer" wrote:

> Secondly, the video chip doesn't show up on the PCI bus.  Although XFree86
> 4.0 apparently supports the controlfb (which is what the 8500 has), it
> also needs a BusID to be used.  Am I out of luck with using XFree86 4.0 or
> newer with my machine?  Or generically, is anyone without a card on the
> PCI bus out of luck?

No, the contrary, you're very lucky! :)

As the chip doesn't show up, the X server can't deactivate it. So you don't
need to specify a bus ID (which would prevent the server of disabling the chip ;).


Michel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
