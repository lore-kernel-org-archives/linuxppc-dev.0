Date: Mon, 24 May 1999 13:37:04 -0400 (EDT)
From: Kevin Hendrickson <hndrcksn@net178019.hcv.com>
Reply-To: Kevin Hendrickson <hndrcksn@net178019.hcv.com>
To: roboj <roboj@ibm.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: CDROM Problems with 2.2.9
In-Reply-To: <Pine.LNX.3.96.990515172702.20309B-100000@net178019.hcv.com>
Message-ID: <Pine.LNX.3.96.990519115540.3051B-100000@net178019.hcv.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 15 May 1999, Kevin Hendrickson wrote:

> 
> On Fri, 14 May 1999, roboj wrote:
> 
> > 
> > After compiling the recent linux kernel (2.2.9), I've been getting an error
> > message which I have included below.  I get it at boot time and it continues
> > printing in an infinite loop.  Also, the computer seems to be trying to access
> > my cd-rom drive (Toshiba scsi, /dev/scd0 linked to /dev/cdrom). Running power
> > computing powerbase.  Anyone ever got a similar error message that can offer
> > any suggestions?  Everything works ok in linux vers. 2.2.6-ac3.
> 
> I get something similar on my S900 dual 180Mhz machine with a Matshita CD. 
> It seems more likely to happen when I'm cold booting up my machine, but
> can also happen after launching from BootX in the Finder. I noticed it
> after I moved to the 2.2.6 kernels (I'm currently using 2.2.6-15apmac.) 
> Sometimes I have to reboot several times in a row before it gets past the
> CD which is target 3 on my internal SCSI bus (MESH) 

I just noticed this morning that I cannot mount anything in this CD drive. 
I have a CD-R drive at target 5 on my external SCSI bus that can mount CDs
fine, but the CD drive mentioned above gives I/O errors and can lock up
the machine if I try to mount it or run od on it too many times. I don't
know whether this happened with earlier 2.2.x kernels because I haven't
had to mount anything in a while. This CD drive mounted fine under the
2.1.x kernels.

Kevin Hendrickson 
*--------+---------+---------+---------+---------+---------+---------+-*
Kevin Hendrickson          "On the internet, no one knows you're a dog."
hndrcksn@net178019.hcv.com   "Why, oh why, didn't I take the BLUE pill?"   
hndrcksn@braincraft.com   _DreaD_    http://net178019.hcv.com/~hndrcksn/ 




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
