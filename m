Date: Sat, 15 May 1999 17:37:54 -0400 (EDT)
From: Kevin Hendrickson <hndrcksn@net178019.hcv.com>
To: roboj <roboj@ibm.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: CDROM Problems with 2.2.9
In-Reply-To: <373C946C.45802CE6@ibm.net>
Message-ID: <Pine.LNX.3.96.990515172702.20309B-100000@net178019.hcv.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 14 May 1999, roboj wrote:

> 
> After compiling the recent linux kernel (2.2.9), I've been getting an error
> message which I have included below.  I get it at boot time and it continues
> printing in an infinite loop.  Also, the computer seems to be trying to access
> my cd-rom drive (Toshiba scsi, /dev/scd0 linked to /dev/cdrom). Running power
> computing powerbase.  Anyone ever got a similar error message that can offer
> any suggestions?  Everything works ok in linux vers. 2.2.6-ac3.

I get something similar on my S900 dual 180Mhz machine with a Matshita CD. 
It seems more likely to happen when I'm cold booting up my machine, but
can also happen after launching from BootX in the Finder. I noticed it
after I moved to the 2.2.6 kernels (I'm currently using 2.2.6-15apmac.) 
Sometimes I have to reboot several times in a row before it gets past the
CD which is target 3 on my internal SCSI bus (MESH) 

> SCSI: aborting command due to timeout pid 3, scsi 0, channel 0, id 1
> 
> mesh_abort (c0374000)
> mesh: state at c0374278, regs at f3010000 dma at f3008000
> ct = 0, seq = c , bs = 6000, fc = 0, exc = 0, err = 0, im = 7, int = 0,
> sp = 2, dma stat = c0, cmdptr = 364010, phase = 0, msgphase = 0, comm_tgt = 1,
> data_ptr = 0, dma_st = 0, dma_ct = 0, n_msgout = 0
> 
> target 1: req = 0374000 goes_out = 0, saved_ptr = 0
> 
> SCSI Host 0 abort (pid3) timed out - resetting
> SCSI bus is being reset for host 0 channel 0
> 
> mesh reset 2
> mesh: SCSI bus reset detected: waiting for end...done

Kevin Hendrickson
*--------+---------+---------+---------+---------+---------+---------+-*
Kevin Hendrickson          "On the internet, no one knows you're a dog."
hndrcksn@net178019.hcv.com   "Why, oh why, didn't I take the BLUE pill?"   
hndrcksn@braincraft.com   _DreaD_    http://net178019.hcv.com/~hndrcksn/ 


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
