Date: Mon, 8 Mar 1999 13:24:56 -0800
From: Sean Harding <sharding@gutenberg.uoregon.edu>
Reply-To: Sean Harding <sharding@OREGON.UOREGON.EDU>
To: Hollis R Blanchard <hollis+@andrew.cmu.edu>
cc: Sean Harding <sharding@OREGON.UOREGON.EDU>,
        Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: platinumfb problems
In-Reply-To: <Pine.LNX.3.96L.990308160733.20767A-100000@unix48.andrew.cmu.edu>
Message-ID: <Pine.SGI.4.10.9903081321340.11304-100000@gutenberg.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 8 Mar 1999, Hollis R Blanchard wrote:

> Are the changes you made to platinumfb.c general fixes, or specific hacks? I
> heard someone else talking about a funny line, too (LinuxPPC@associate.com, I
> believe).

My changes make it work for Xpmac, but I'm willing to bet that they aren't
good for XF68. I still can't figure out how to get rid of the line, so I
just run in 16bpp...

I basically just removed the bit shift ("<<scale") from the three out_8()
calls that had it. That seems to have fixed the colors problem at least.

sean

-- 
Sean Harding sharding@oregon.uoregon.edu|"art may imitate life
http://gladstone.uoregon.edu/~sharding/ | but life imitates t.v."
Consulting: http://www.efn.org/~seanh/  | --ani difranco


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
