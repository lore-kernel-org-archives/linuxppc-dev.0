Date: Thu, 14 Jan 1999 20:30:56 -0700 (MST)
From: Brad Midgley <brad@pht.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: floppy driver bug: write-protect
In-Reply-To: <Pine.LNX.3.95.981115182106.10912A-100000@pacific.pht.com>
Message-ID: <Pine.LNX.3.95.990114202630.28345C-100000@pacific.pht.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This message was stuck in a mail queue since november!! (it was my own
sysadmin's fault :)

so when I say the current pmac kernel I really mean the pmac kernel of
November 15, 1998. 

argh, i just checked and this bug is present in vger-pre5.

brad

> 
> is this a known bug?
> 
> on intel linux, if you try to mount a write-protected floppy disk
> read-write, the mount succeeds but is demoted to read-only. 
> 
> the current pmac kernel will mount the disk read-write and will allow
> "writes" to the disk. the writes even appear to succeed and the mounted
> filesystem returns really strange results when you look at it (it's
> caching the "writes" and everything seems normal until uncached data has
> to be loaded from the disk!)
> 
> is it known how to query the drive for the write-protect status? does this
> problem affect any other removable media?
> 
> brad
> 
> 


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
