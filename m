Date: Mon, 23 Aug 1999 15:21:40 -0600 (MDT)
From: Brad Midgley <brad@pht.com>
To: "David A. Gatwood" <dgatwood@mvista.com>
cc: Tom Rini <trini@disparity.net>, rshaw@inficad.com,
        Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: imac exception (Re: BootX enhancement request)
In-Reply-To: <Pine.LNX.3.96.990823140728.23476T-100000@mvista.com>
Message-ID: <Pine.LNX.3.95.990823151755.20705A-100000@pacific.pht.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


it should be noted that the imac, although it has the same 15-pin video
connector internally, doesn't follow the rules and apply the right signals
to its sense pins. so you need a special case in your detection code for
this beast. (the signals from the sense pins suggest the computer use a
resolution/synch that the monitor doesn't even support)

> Feel free to look at the code MkLinux hass to read the sense pins.... 
> Granted, it's not actually being _used_ for anything, since MkLinux
> doesn't change resolution, but it's there in the original PDM video
> driver.  There will obviously be differences for other video hardware, but
> it _might_ at least provide some useful inspiration or something.

Brad
brad@pht.com | http://www.pht.com/~brad/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
