Date: Tue, 24 Aug 1999 00:52:11 -0400 (EDT)
From: Tom Rini <trini@disparity.net>
To: Jerry Quinn <jquinn@nortelnetworks.com>
cc: brad allison <jackal@aol.net>, rshaw@inficad.com,
        Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org, puetzk@iastate.edu
Subject: Re: BootX enhancement request
In-Reply-To: <14273.46467.61746.180371@gargle.gargle.HOWL>
Message-ID: <Pine.BSF.3.96.990824005043.86405M-100000@silver.teardrop.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 23 Aug 1999, Jerry Quinn wrote:

> >> "Tom" == Tom Rini <trini@disparity.net> writes:
> 
>  Tom> So you want BootX to be able to do what Monitors & Sound can do.  Either
>  Tom> pick a mode there and use BootX from MacOS, or once 2.4.0 rolls around,
>  Tom> specify video=aty128fb:1024x768@75 (or so).  There is no need for BootX
>  Tom> to do this.
> 
> Probably more to the point, we should strive to provide some easy way of doing
> it.  How do MacOS and Windows deal with the problem of different monitors and
> resolutions?  I know on the Mac so far, I automatically get the available
> resolutions, although Apple-style monitors have extra sense pins to provide
> the info.

Don't they both stick you at 640x480@60, and make you choose up from
there?  (I know I've seen waaay to many  640x480 PCs around in these dorms
lately).  There are ways to sense modes, and it is implemented in some
drivers (most, iirc)

> Ideally, I shouldn't have to ever think about my monitor or have to add
> command line args to the kernel.  Such twiddling should be as rare as
> possible. 

So set something in MacOS. :)

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
