Date: Thu, 10 Jun 1999 16:57:32 -0400
From: Daniel Jacobowitz <drow@false.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Q: control is a C&T 65550?
Message-ID: <19990610165732.A3984@drow.res.cmu.edu>
References: <19990608095844.A5496@drow.res.cmu.edu> <199906102051.WAA00299@piglet.cpu.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199906102051.WAA00299@piglet.cpu.lu>; from Michel Lanners on Thu, Jun 10, 1999 at 10:51:08PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jun 10, 1999 at 10:51:08PM +0200, Michel Lanners wrote:
> - The RAMDAC is an Apple ASIC as well, named RaDaCal, integrating the
> RAMDAC, CLUT and a hardware cursor device. Use and programming of the
> hardware cursor are yet undocumented. The known details are that the
> cursor needs to be drawn by the OS as some kind of sprite, in an
> offscreen VRAM portion reserved at the end of each scanline. The
> vertical position needs to be drawn at the right offset, whereas the
> horizontal position of the cursor is taken care of by RaDaCal, probably
> by setting the horizontal position info in a register. Vertical
> movements therefore need a redraw by the OS.

I intend to see what I can do about documenting the hardware cursor. 
With all the excellent advice I've gotten, I expect it won't be too
difficult.

> Obviously, all of the above information can be totally wrong ;-). If
> there is any Apple engineer in the audience who knows better, please do
> speak up!

Unfortunately, the Apple engineers in the audience aren't allowed to :(

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
