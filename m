Message-ID: <3A6B6104.4935B5CA@iiic.ethz.ch>
Date: Sun, 21 Jan 2001 23:21:56 +0100
From: Michel Dänzer <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Steven Hanley <sjh@wibble.net>
CC: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dri status? (agpgart?)
References: <20010121223637.A32549@wibble.net>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Steven Hanley wrote:

> I am just now grabbing the cvs repository from dri.sourceforge.net to see if
> I can get dri running on my pismo, now I am wondering what the current
> status is?
>
> (I am of course doing this because gareth hughs was at linux.conf.au over
> the last few days, and I was completely blown away by the performance of 3d
> stuff on his laptop (it was absolutely amazing to say the least))

Yes, it will rock once it works. :)

> Last I heard for ppc was that we could do dri but not the agpgart stuff,
> which means it doesnt go quite as fast as we may wish

That was about the situation a few months ago. Currently, the r128 DRI doesn't
work without AGP GART.

PCI GART support is currently being developed in a branch of the DRI CVS, but
I haven't got it to work on my Pismo yet (see the other thread about 'PPC
lockups'). As always, any help is much appreciated! :)

As for AGP GART, once PCI GART works I may have a stab at that. But I don't
expect it to give a substantial performance boost.


> (no mtrr write combining or some such)

This is an ia32 thing and doesn't affect us.


Michel


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
