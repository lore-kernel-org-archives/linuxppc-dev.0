Subject: RE: Wolfgang's updates 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Tue, 13 Mar 2001 15:03:14 -0000
Message-ID: <EADB10BAC266A14A85ECBF8686A73E310A9112@kolkrabbi.flaga.is>
From: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kd@flaga.is>
To: <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> -----Original Message-----
> From: Wolfgang Denk [mailto:wd@denx.de]
> Sent: 13. mars 2001 14:31
> To: Kári Davíðsson
> Cc: linuxppc-dev@lists.linuxppc.org
> Subject: Re: Wolfgang's updates
>
>
> In message
> <EADB10BAC266A14A85ECBF8686A73E3108AFC4@kolkrabbi.flaga.is> you wrote:
> >
> > > * AMD   flash chip support
> > > * INTEL flash chip support
> ...
> > >   PCMCIA port, and for real PCCARD interfaces like CompactFlash or
> > >   harddisk adapter cards, but without need for the full PCMCIA
> > >   package; also usable for boot devices).
> ...
> > Isn't this exactly what mtd is dooing, i.e. generating a general
> > interface to flash devices.
>
> It's not a general  interface,  just  an  ordinary  character  device
> driver.

One of the interfaces that mtd implements is a character interface.

>
> Yes, you probably can  replace  it  by  MTD,  and  this  is  what  we
> eventually plan for the future. But our flash driver pre-dates MTD by

Great.

> som  time,  and  has  been  around  since  2.2.5 or so. It is used by

I know. I was using it with the 2.2.5. and made it work with the
AM29LV160BT
although I am not shure if the pathces ware ever used by anyone except
me.

> several of our customers, and we will have to maintain  it  for  some
> time anyway.
>
> And I  don't  really  see  a  problem  with  having  two  independend
> solutions for similar problems.

Well I was just saying that Linus has rejected patches before because
the
problem was allready solved (in a diffrent way maybe) elsewhere.
(For example ggi v.s. X11, devfs in busybox v.s. /proc and probably a
lot more)

>
> For instance, so far MTD does not even  compile  for  CFI  conformant
> flash chips; last time I tried I got this:
>
> cfi_cmdset_0002.c:304: #error not support big endian yet

The resent snapshots of the mtd system works for me, i.e. the character
device part.
Thats on an mpc823e with one Intel TE28F320 flash chip on a 2.4.x
kernel.
Although I have not tried to put a filesystem on it yet, I don't
foreseeing it as becoming
a big problem, since the low level driver seem to work (fingers crossed
8-) ).

>
> The other patch to enable IDE devices like harddisks or  CompactFlash
> as  boot  devices  using  the  PCMCIA port of the MPC8xx is - AFAIK -
> something that is not even addressed by MTD. Nor was there any  other
> working solution for it.
>
> > Isn't this a duplication of work, and deemed to be rejected from the
> > official kernel because the mtd is allready in the official kernel?
>
> Even with MTD - why generally reject  an  alternative  solution?  For
> instance, we have several types of filesystems, too.

Well, like I said before it has happened. The reason probably beeing, it
is easier to maintain in the long run.

>
> The "one size fits all" method does not apply  to  embedded  devices,
> and that's what I have in mind.

But still we are all trying to make "one fit all", i.e. the Linux
kernel,
and that is what I have in mind.

>
> If you don't like it, you don't have to use it. It does not hurt you.

Of course.

>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> In C we had to code our own bugs, in C++ we can inherit them.
>
Regards,

K.D.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
