Message-ID: <37C1AF16.695C8998@motorola.com>
Date: Mon, 23 Aug 1999 13:29:11 -0700
From: Robert Shaw <robert.shaw@motorola.com>
Reply-To: rshaw@inficad.com
MIME-Version: 1.0
To: brad allison <jackal@aol.net>
CC: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org,
        puetzk@iastate.edu
Subject: Re: BootX enhancement request
References: <Pine.SGI.4.00.9908231613030.7470-100000@osiris.office.aol.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I think you missed my point.  Don't get me wrong, that's cool to know.
> But I was thinking more along the lines of a drop down menu to set the
> resolution from BootX rather than cryptic kernel arguements.

Ok, that's reasonable. Any thoughts Ben?

> It seems the 2.2.10 kernel will not sync to the video settings at all
> without the kernel arguements.

Strange, mine does. :|
Have you tried the latest 2.2.10 kernel I posted last night? Does it mess up also?

>
> Well i think putting Xautoconfig in the rc.local file is still a good
> idea.
>

Not if you make changes to the XF86Config file for the USB xkb stuff. Xautoconfig
will mess it all up and switch it back to PC settings. There is a warning in the
Kernel HOWTO about this when setting up the xkb settings.

-Robert
mailto:rshaw@inficad.com
http://www.inficad.com/~rshaw/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
