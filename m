Date: Wed, 27 Oct 1999 20:46:05 -0700 (PDT)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: Martin Costabel <costabel@wanadoo.fr>
cc: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: bypassing MacOS using Open Firmware on Apple pmac G3 
In-Reply-To: <3817B62A.71757E99@wanadoo.fr>
Message-ID: <Pine.LNX.4.10.9910272042060.18939-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



martin,
	actually, thats exactly all i had to do, funny eh?  got rid of the
update_vm_cache and its been working fine.  I've been using 2.3.22 for a
week or so now, built many kernels which i cp'd numerous times over to one
of my hfs partitions, played many hours of mp3's which reside on another
hfs partition, and i even might have done some deleting of files on my hfs
too.  not a single crash with 2.3.22 so far and my files on hfs aren't
corrupted (yet, heh)...


ani


On Thu, 28 Oct 1999, Martin Costabel wrote:

> [...]
> >         2.4?  if its 2.3 you mean, hfs works fine with the latest (2.3.22
> > on my box is doing hfs fine), 
> [...]
> 
> Amid all the shouting, no one seems to have picked up on this.
> 
> Are you serious about hfs running correctly in 2.3.22? If yes, this
> would be a major breakthrough. What is your patch (certainly more than
> just commenting out the undefined "update_vm_cache")?
>
> Martin
> 


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
