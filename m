Mime-Version: 1.0
Message-Id: <v04210104b3e769b9cab0@[209.239.164.143]>
In-Reply-To: <14273.46467.61746.180371@gargle.gargle.HOWL>
References: 
 <Pine.SGI.4.00.9908231613030.7470-100000@osiris.office.aol.com>
 <Pine.BSF.3.96.990823162311.86405K-100000@silver.teardrop.net>
 <14273.46467.61746.180371@gargle.gargle.HOWL>
Date: Mon, 23 Aug 1999 14:27:05 -0700
To: linuxppc-dev@lists.linuxppc.org
From: Peter Chang <weasel@cs.stanford.edu>
Subject: Re: BootX enhancement request
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Note: I'm not really active on the linuxppc-dev list (read: lurker), 
but I assume that all of the people on the 'to' list are on the list 
so I've trimmed it back to just the list.

> >> "Tom" == Tom Rini <trini@disparity.net> writes:
>
> Tom> So you want BootX to be able to do what Monitors & Sound can do.  Either
> Tom> pick a mode there and use BootX from MacOS, or once 2.4.0 rolls around,
> Tom> specify video=aty128fb:1024x768@75 (or so).  There is no need for BootX
> Tom> to do this.

I agree w/ this, if mostly because bootX would either need to do a 
lot of querying to determine what the board/monitor combo could do or 
there would be yet another list of supportable modes that might get 
out of sync w/ what's already in the X config stuff.

At 16:56 -0400 08.23.1999, Jerry Quinn wrote:
>How do MacOS and Windows deal with the problem of different monitors and
>resolutions?  I know on the Mac so far, I automatically get the available
>resolutions, although Apple-style monitors have extra sense pins to provide
>the info.

W/ the coming of win9x, the pnp stuff wants to load 'extra' 
information about monitors etc taht it detects. This information 
'overrides' any monitor sense stuff that might be present (I've never 
seen a pc monitor like this), and restricts the list of availible 
modes presented to the user. I've since lost the brain cells involved 
(thank goodness), but you can 'hand edit' the .inf file (or whatever) 
to get modes that you know the monitor supports but that are not 
advertised. (Well, my co-workers at 3dfx and I would do this because 
we 'knew' our brand new viewsonic monitors could do a lot more than 
whatever appeared in the list).

I think that the lack of sense pins for normal vga connectors is part 
of the reason why windows still asks if the test pattern appears 
correctly on the monitor. It knows what the card can support, but not 
whether the user is using some crappy monitor that can't synch.

\p

---
We all enter this world in the same way:
naked; screaming; soaked in blood.
But if you live your life right, that kind of
thing doesn't have to stop there. -- Dana Gould

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
