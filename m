Date: Tue, 9 Feb 1999 10:59:55 -0800 (PST)
From: Eric Guenterberg <mavpion@fire.csua.ucla.edu>
To: Paul.Mackerras@cs.anu.edu.au
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Linux 2.2.1 Kernel scsi troubles
In-Reply-To: <199902090159.MAA04789@tango.anu.edu.au>
Message-ID: <Pine.LNX.3.96.990209105722.22941B-100000@fire.csua.ucla.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 9 Feb 1999, Paul Mackerras wrote:

> Eric Guenterberg <mavpion@fire.csua.ucla.edu> wrote:
> 
> > I recently compiled the the Linux 2.2.1 kernel, but I can't get it to boot
> > because when it is booting it aborts the reading of the harddrive that
> > contains my root partition.
> > 
> > I have a PowerMac 7600/132
> [snip]
> > It says:
> > scsi host 0 aborted
> 
> Could you try the kernel (vmlinux.gz) in
> ftp://samba.anu.edu.au/pub/linux-pmac/test/
> and let me know if it does the same thing?

Same error--it says "MESH: host 0 Aborted"

I have a MESH driver for my internal scsi chain. It does recognize the
cdrom (the other device on MESH). and the my jaz drive, which is on the
other chain.

I am using BootX. I couldn't get Boot Variables working again (I have my
root on the first device, which also holds my primary mac partition).

A 2.1.131 kernel does work.

--Eric Guenterberg


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
