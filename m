Date: Tue, 9 Mar 1999 09:05:02 -0500 (EST)
From: Tom Rini <tmrini@ntplx.net>
To: Hollis R Blanchard <hollis+@andrew.cmu.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: No-IDE kernel compile link errors
In-Reply-To: <Pine.LNX.3.96L.990308225823.26298C-100000@unix48.andrew.cmu.edu>
Message-ID: <Pine.SUN.4.02.9903090859070.14871-100000@sea.ntplx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 8 Mar 1999, Hollis R Blanchard wrote:

> When I rerun 'make menuconfig', I find that the IDE stuff has been re-enabled
> on me. My other changes were saved, though. Examining the .config file, I find
> that CONFIG_BLK_DEV_IDE_PMAC and CONFIG_PARIDE_PARPORT are both set to y.

The CONFIG_PARIDE_PARPORT is just a "test" variable, it doesn't turn
on/off anything in the code, just when the config stuff is going on.  From
what I remember of drivers/block/Config.in, that's prolly a good thing
that it's set.

> On a related note, I've always wondered who maintains the Makefiles for the
> kernel. Is it communal, and if so, are patches to the Makefiles submitted just
> like source patches?

It sounds like you accidently set the CONFIG_BLK_DEV_IDE to Y in the
arch-spec area (where early BootX Text and TotalImpact card support is).
This ugliiness is fixed by one of the ide patches in the patches dfir on
nmt.

--
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
