Date: Tue, 5 Jan 1999 09:45:30 +1100
Message-Id: <199901042245.JAA00826@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: brad@pht.com
CC: linuxppc-dev@lists.linuxppc.org, p1rabbit@halcyon.com
In-reply-to: <Pine.LNX.3.95.990104100936.8496A-100000@pacific.pht.com>
	(message from Brad Midgley on Mon, 4 Jan 1999 10:18:56 -0700 (MST))
Subject: Re: 2.2.0pre2 SCSI problems, more (fwd)
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.3.95.990104100936.8496A-100000@pacific.pht.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> that's the SAME drive that aborts for me in 2.2.0p4. mine is also
> connected to mesh. my 2.1.30 identifies it as: 
> 
> Vendor: QUANTUM   Model: FIREBALL1280S     Rev: 630G
> 
> i don't see it blacklisted. something just makes it want to abort now. the
> scary thing about this is this drive ships STANDARD in 1gig 7500's. that's
> a lot of computers that suddenly can't run linux. 

I have a 7600 but it no longer has this disk in it (it's in another
machine).  Could somebody with a 7600 and this disk and the kernel
sources do the following: change drivers/scsi/mesh.c to #define
MESH_DBG and to initialize mesh_debug_targets to 1, and send me the
resulting debug log?

I may be able to take my fireball1280S out of the machine it's in if
we can't resolve the problem soon.

Paul.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
