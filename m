Date: Fri, 21 May 1999 14:47:50 -0400 (EDT)
From: Kevin Hendrickson <hndrcksn@net178019.hcv.com>
To: Ray Allis <ray@bcstec.ca.boeing.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Umax S900 CD Rom problems...
In-Reply-To: <37447E78.56C232F9@bcstec.ca.boeing.com>
Message-ID: <Pine.LNX.3.96.990521141437.6255A-100000@net178019.hcv.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 20 May 1999, Ray Allis wrote:

> "Velasquez, Carlos" wrote:
> 
> > Hello,
> >
> > Has anyone successfully installed  Linux on a Umax S900 Mac clone? If so,
> > can you share your stories with me? I am having problems installing Linux on
> > my Umax S900 (225 Mhz ppc with 162Meg ram, ixMicro Twin Turbo 8Meg video
> > card.) Apparently, when I try to do a CD install, the installer doesn't
> > recognize the CD Rom device. I believe I have a Matshita CD rom drive
> > installed as an internal SCSI device (bus 0, Id 4).
> 
> I gave up. ;)  First attempt, the installer did not recognize the Twin
> Turbo.  Someone on this list offered a fixed installer.  Then, the
> machine lost track of the CD, so the installer displayed o.k. but could
> not see anything to install. ;)  Then the whole SCSI went invisible - no
> CD, no floppy, no Zip.  Soooo, sent it to the shop, where they replaced
> the motherboard (where the SCSI chip was mounted).  Now the installer
> won't write (correctly) to the internal hard drives.  Seems the E100
> chip sorta refuses to let the two 2-gig disks be anything but RAID, no
> matter how I initialize them.  And then too, it's a twin processor SMP,
> and THAT won't run anything but the Umax-supplied demos (MacOS 7.6) and
> then for a maximum of 30 minutes. 

What version of LinuxPPC are you trying to install? I've gotten R4.0 and
pre-R5 to install on my dual 180MHz S900. Though both installed over the
net, but both were able to see both SCSI busses and both my Matsushita CD
and Panasonic CD-R. I've also gotten it to run MacOS 8.0 and 8.1. Haven't
bothered with 8.5 or 8.6 yet. I am currently having my latest kernel
2.2.6-15apmac to use my Matsushita CD though. I don't use it very often,
so I don't know if any earlier 2.2.x kernels also gave trouble. My CD-R
works just fine though.

> 
> I'm parting it out ;).
> 
> Ray Allis
> 
> 

*--------+---------+---------+---------+---------+---------+---------+-*
Kevin Hendrickson          "On the internet, no one knows you're a dog."
hndrcksn@net178019.hcv.com   "Why, oh why, didn't I take the BLUE pill?"   
hndrcksn@braincraft.com   _DreaD_    http://net178019.hcv.com/~hndrcksn/ 


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
