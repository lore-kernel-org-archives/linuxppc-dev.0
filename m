Date: Thu, 15 Jul 1999 10:34:31 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@mvista.com>
To: Dave Weis <djweis@plconline.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: performa 6214 support?
In-Reply-To: <Pine.LNX.4.10.9907151220530.25231-100000@catbert.desm.plconline.com>
Message-ID: <Pine.LNX.3.96.990715103205.6283H-100000@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 15 Jul 1999, Dave Weis wrote:

> > > has anyone been working on getting machines like the above working with
> > > linuxppc? i looked thru the compatibility lists and it was mentioned as
> > > non-supported. i think mklinux would be closer but i remember seeing
> > > something about trying to merge them.
> > 
> > MkLinux is a lot closer, but it doesn't work yet.  That machine falls
> > roughly into the category of 68k macs upgraded with PPC upgrade cards. 
> > There are a few differences, but it's basically a Quadra 630.
> 
> so it would require using more of the mac-68k stuff? if i had time, should
> i start with the mklinux stuff? would i have to modify the mach kernel or
> just the linux kernel?

Mach Kernel.  I've gotten most of the interrupt handling support in place,
I _think_, and most of the devices know about their locations in the
Performas.  I just no longer have a machine nearby for testing.  Also,
some machines in that class don't get past the splash screen, and I have
no idea why.  Probably something in the early memory mapping stuff or
something similar.  Dunno.  I'm thinking that maybe it might be dependent
on how much RAM the machine has, but I had no way to test that hypothesis.


David


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
