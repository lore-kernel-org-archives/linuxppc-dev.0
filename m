Date: Wed, 14 Nov 2001 13:20:04 -0500 (EST)
From: Daniel Berlin <dan@cgsoftware.com>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: DFP support for kernel radeonfb.c added
In-Reply-To: <20011114175006.VAAL9849.tomts10-srv.bellnexxia.net@there>
Message-ID: <Pine.LNX.4.33.0111141318380.20197-100000@www.cgsoftware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Just a note, on the tibook rev b, the EDID is in EDID1 for the LCD.
No idea if it'll make an EDID2/EDID if you plug in an external monitor.
>
> All of this depends on their being an EDID block in /proc under the Radeon
> device tree (it exists on my machine).  You can simply look in /proc in
> the device_tree to see if one exists on your machine (need to have the
> monitor connected for it to be created).
>
> Since there are a lot of changes and since other people have submitted
> radeon patches recently, I have attached my complete files (radeonfb.c and
> radeon.h) in the form of a tar archive to this e-mail so that others may
> more easily understand the changes.
>
> I hope this helps others with flat panels but be warned I have only tested
> them on my own machine.  So don't come back to me if your FP goes up in
> smoke.  Use at your own RISK!
>
> BTW: Using a dviAtor, and an Apple 17 inch flat panel is a real blast and
> now all of my eye strain is gone!
>
> Have fun!
>
> Kevin
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
