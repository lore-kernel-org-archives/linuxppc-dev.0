Date: Fri, 9 Apr 1999 10:20:52 -0700 (MST)
From: Matt Porter <mmporter@home.com>
To: Simone Piccardi <piccardi@fi.infn.it>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC on a Motorola MVME2400
In-Reply-To: <370DBBD3.9559B590@fi.infn.it>
Message-ID: <Pine.LNX.3.96.990409101623.32668B-100000@liberty.chnd1.az.home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 9 Apr 1999, Simone Piccardi wrote:

> Hi,
> we buy just some day ago a Motorola MVME 2431 VME board, to use it for
> data acquisition for a Cosmic Ray Physics experiment. I saw from
> previous mail that someone has started LinuxPPC on this board. 
> Could you give us some info about it? 
> Because I'm new to this board and to LinuxPPC (I always used linux on a
> PC machine), there is some place (or any kind of documentation)
> describing the boot procedure (we would like to use the net booting by
> tftp)? 

I posted a patch (check the archives) for DEC21x4x driver a while back.
You'll need that on the 2400.  I don't know if it's in Gabriel's patches
especially since he doesn't need it on his 2600.

The 2.2.5 vger stuff should work well with this board and the de4x5.c
patch, though it won't have OpenPIC support and you may need to modify
interrupt routing for PMC slots if necessary.  I use a local repository
with all this stuff that is has not yet been rolled in and I haven't had a
chance to sort out some patches.

--
Matt Porter
mmporter@home.com
This is Linux Country. On a quiet night, you can hear Windows reboot.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
