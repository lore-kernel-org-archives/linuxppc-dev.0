Date: Mon, 23 Aug 1999 14:10:59 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@mvista.com>
To: Jerry Quinn <jquinn@nortelnetworks.com>
cc: Tom Rini <trini@disparity.net>, brad allison <jackal@aol.net>,
        rshaw@inficad.com, Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org, puetzk@iastate.edu
Subject: Re: BootX enhancement request
In-Reply-To: <14273.46467.61746.180371@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.3.96.990823140728.23476T-100000@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 23 Aug 1999, Jerry Quinn wrote:

> Probably more to the point, we should strive to provide some easy way of doing
> it.  How do MacOS and Windows deal with the problem of different monitors and
> resolutions?  I know on the Mac so far, I automatically get the available
> resolutions, although Apple-style monitors have extra sense pins to provide
> the info.
> 
> Ideally, I shouldn't have to ever think about my monitor or have to add
> command line args to the kernel.  Such twiddling should be as rare as
> possible. 

Feel free to look at the code MkLinux hass to read the sense pins.... 
Granted, it's not actually being _used_ for anything, since MkLinux
doesn't change resolution, but it's there in the original PDM video
driver.  There will obviously be differences for other video hardware, but
it _might_ at least provide some useful inspiration or something.


David


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
