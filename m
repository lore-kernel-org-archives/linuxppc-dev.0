Message-ID: <37553687.F6737A9@switchboard.ericsson.se>
Date: Wed, 02 Jun 1999 15:49:59 +0200
From: Magnus Damm <damm@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.muc.de>
CC: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: MPC8xx: wrong zimage_start
References: <199906021206.OAA14059@denx.muc.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Hi,

Hi there!
 
> I think I need some help... I'm trying to port Linux to a  "non-stan-
> dard"   MPC860  board. 

I've ported linux to a few custom 860 boards.

> Obviously,  it  does  not  provide  the  same
> environment as the EPPC-Bug on the MBX860 boards.

I am with you.

> Can anybody see what I'm doing wrong, or at least give me a few hints
> where to look?

Well, I havn't had any trouble like that.

I started loading a 'vmlinux' to address 0 and started at address 0x0c.
That was just because I didn't like the things that was done in the
boot-code for the zImage.
The MBX board reads some stuff from the NVRAM and does a few wierd
things.

I've made a port to an ADS board from motorola, I've sent the patches to
Dan Malek.

I use the embedded-2.2.5 tarball, what code do you use?
My patches are for the embedded-2.2.5 code.

I've got a bootrom that loads a zImage or vmlinux from ATA-flash or
romdisk.
That might be a good start.

Another thing - remember to read the errata for the 860.
Revisions before C tend to have some problems.
And 860T has still (B3) got problems.
 
Good luck! /

magnus

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
