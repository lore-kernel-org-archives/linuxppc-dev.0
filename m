Date: Mon, 28 Jun 1999 13:02:10 -0400 (EDT)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: "Velasquez, Carlos" <carlos.velasquez@ssmb.com>
cc: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: Getting started with X (was Re: your mail)
In-Reply-To: <BFC0587634C3D111AACB00805FA766FA02C1C5E3@exchny12.ny.smb.com>
Message-ID: <Pine.LNX.3.96L.990628125706.1700J-100000@unix47.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 28 Jun 1999, Velasquez, Carlos wrote:
> 
> Finally got Linux running and after trying out some stuff I in text mode I
> am ready to move up into the world of X windows. How exactly do I get
> started?? What commands do I issue to start the X server, etc etc? Anyone
> know any good books or links where I can get documentation??

First, as root run 'Xautoconfig' (install the rpm if you don't have it
already).  This will create an X config file for you (/etc/X11/XF86Config).

Then, as a user, type 'startx'.

> Also, when booting with BootX, should I enable the "Video Drivers" option? I
> have a Umax S900 running @ 225Mhz with 162 Meg ram and an ixMicro Twin Turbo
> 8 Meg graphics card. YDL is booting of my Jazz Drive (2.1gig)

I think I've heard of a Twin Turbo driver, but if it exists it's not in kernel
2.2.9. You might have to stick with what you're using now.

-Hollis



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
