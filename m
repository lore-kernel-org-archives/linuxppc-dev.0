Date: Mon, 26 Jul 1999 16:57:32 -0400 (EDT)
From: Peter Handel <phandel@cise.ufl.edu>
To: Brad Boyer <flar@cegt201.bradley.edu>,
        "Robert M. Fuhrer" <rmf@asgard.cs.columbia.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Kernel adb / sound conflict [was Re: Question about getservbyport()
 -]
In-Reply-To: <199907262017.PAA17351@cegt201.bradley.edu>
Message-ID: <Pine.GSO.4.05.9907261649260.27203-100000@eclipse.cise.ufl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 26 Jul 1999, Brad Boyer wrote:

>      struct servent sd, *sp;
>      sp = getservbyport(23, "tcp");
>      if(sp)
> 	   sd = *sp;

Thanks a lot for the good advice ... this was actually part of a
program I was porting, and had forgotten about pointer usage.

Now, if I could only get this problem solved:

On Tue, 20 Jul 1999, Peter Handel wrote:

> PowerCenter Pro 210 / 96MB RAM.
> Say I'm playing an mp3 with either xmms or mpg123.  If I move a window
> around w/the mouse, the music will stop completely!  It may also
> happen when simply moving the mouse around, leading me to believe that
> it is an adb bug.  I have to quit xmms/mpg123 and restart it for it to
> work again.  This only happens with kernels I compile myself, and one
> precompiled one I've stumbled across from Cort's site.  I have even
> tried compiling 2.2.10 and 2.3.6 with all default values, but still
> the same problem. (Had same problem under r4!)  The only constant here
> is egcs 2.91.66, which I built under r4 and which came prebuilt in r5.  
> This has been extremely frustrating, as I'd like to start playing with
> the kernel code myself.

I can't think of anything that would cause that. With 2.2.10, 'make
pmac_config' and then when you 'make menuconfig' look carefully through all
the options. You may have more luck asking this on the mailing lists (esp.
linuxppc-dev).

Sorry.

hb
--
LinuxPPC Support


-------------------------------

Thanks,
Peter

-- 
phandel@cise.ufl.edu      great ... to receive a mark [smart card?] on his
www.cise.ufl.edu/~phandel right hand or on his forehead, so that no one could
FAX: (561) 619-8051       buy or sell unless he had the mark"-Revelation13:16
> > You are perfectly free to believe what you want to, and so am I.
> Actually, this turns out not to be the case. God does not give us
> the freedom to believe anything we wish. We are morally obligated to
> believe the truth. Doing anything else is a sin. You are not free to
> interpret the Bible anyway you wish. -DFL (Pretty neat, huh?)





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
