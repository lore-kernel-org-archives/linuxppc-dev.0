Date: Wed, 3 Feb 1999 17:54:38 -0700 (MST)
From: Brad Midgley <brad@pht.com>
Reply-To: Brad Midgley <brad@pht.com>
To: Daniel Jacobowitz <drow@false.org>
cc: Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org,
        geiseri@msoe.edu
Subject: Re: scsi hangs [drow@cs.cmu.edu: Re: CD-writers] (fwd)
In-Reply-To: <Pine.LNX.3.95.990118132148.32489A-100000@pacific.pht.com>
Message-ID: <Pine.LNX.3.95.990203174811.1985A-100000@pacific.pht.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


i did a successful burn today! woohoo!

cdrecord: fifo was 0 times empty and 13164 times full, min fill was 92%.

the solution was to move the hard drive with the data on it to the
internal scsi bus on my 7500. the burner (a ricoh) is still on the
53c94. 

so... the 53c94 driver currently doesn't allow enough access to regular
hard drives when you're using the generic device. i don't know how this
relates to disconnect/reconnect or the scheduler. 

it isn't going to be an option for everybody to move their source drives
to another bus but at least we know burning works in some configurations. 

brad

>the author of cdrecord suggests we look at:
> Disabled disconnect/reconnect on the SCSI bus
> A bug in the scheduler or pager in the kernel.



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
