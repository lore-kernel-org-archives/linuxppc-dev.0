Date: Thu, 25 Feb 1999 02:49:56 -0500 (EST)
From: Anirudh Joshi <ajoshi@Glue.umd.edu>
To: Mayan Moudgill <mayan@watson.ibm.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ramdisks, anyone?
In-Reply-To: <9902242039.AA29018@mayan.watson.ibm.com>
Message-ID: <Pine.GSO.3.95q.990225024846.18247B-100000@y.glue.umd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



	I vaugely remember a kernel argument called "ramdisk_size", so (if
you use bootx, but it in the line at bottom) try "ramdisk_size=8192" that
will make the ramdisk 8 megs, or whatever your fancy....


ani


On Wed, 24 Feb 1999, Mayan Moudgill wrote:

> 
> 
> I am trying to build a small initrd, with a linuxrc that does something.
> Does somebody have such a ramdisk.image available?
> Or even some suggestions on what to do?
> 
> I started off by trying to make bash my /linuxrc. Bash
> required ld.so.1, which required libc.so.2, etc....
> 
> This occupied more the 4MB. At that point the /dev/ram on the
> machine I was building the ramdisk started giving problems -
> If I built a bigger /dev/ram, after umount, dd would only
> read the first 4MB.  is there something magical about 4M for ramdisks?
> 
> So I'm stuck..............
> 
> HELP!!!!!!!
> 
> :)
> Mayan
> 


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
