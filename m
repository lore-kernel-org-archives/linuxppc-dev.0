From: "Jerry Quinn" <jquinn@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14273.46467.61746.180371@gargle.gargle.HOWL>
Date: Mon, 23 Aug 1999 16:56:35 -0400 (EDT)
To: Tom Rini <trini@disparity.net>
Cc: brad allison <jackal@aol.net>, rshaw@inficad.com,
        Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org, puetzk@iastate.edu
Subject: Re: BootX enhancement request
In-Reply-To: <Pine.BSF.3.96.990823162311.86405K-100000@silver.teardrop.net>
References: <Pine.SGI.4.00.9908231613030.7470-100000@osiris.office.aol.com> <Pine.BSF.3.96.990823162311.86405K-100000@silver.teardrop.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> "Tom" == Tom Rini <trini@disparity.net> writes:

 Tom> So you want BootX to be able to do what Monitors & Sound can do.  Either
 Tom> pick a mode there and use BootX from MacOS, or once 2.4.0 rolls around,
 Tom> specify video=aty128fb:1024x768@75 (or so).  There is no need for BootX
 Tom> to do this.

Probably more to the point, we should strive to provide some easy way of doing
it.  How do MacOS and Windows deal with the problem of different monitors and
resolutions?  I know on the Mac so far, I automatically get the available
resolutions, although Apple-style monitors have extra sense pins to provide
the info.

Ideally, I shouldn't have to ever think about my monitor or have to add
command line args to the kernel.  Such twiddling should be as rare as
possible. 

-- 
Jerry Quinn                             Tel: (514) 761-8737
jquinn@nortelnetworks.com               Fax: (514) 761-8505
Speech Recognition Research


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
