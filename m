Date: Wed, 15 Sep 1999 18:15:24 -0500
From: erik cameron <cameron@senta.uchicago.edu>
To: Ethan Benson <erbenson@alaska.net>
Cc: Kevyn Shortell <kevyn@apple.com>, Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: New booter
Message-ID: <19990915181524.C10558@senta.uchicago.edu>
References: <19990915113905.031280@mailhost.mipsys.com> <v04210108b4051bfbea54@[192.168.0.1]> <v04210103b4058cbb5883@[17.203.21.242]> <v04210102b405ce2cdefb@[192.168.0.1]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <v04210102b405ce2cdefb@[192.168.0.1]>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Sep 15, 1999 at 02:37:35PM -0800, Ethan Benson wrote:
> anything more then a update to lilo at most.  not a whole new machine 
> or a kludge like creating dedicated partitions just to bootstrap your 
> OS.

i think people were referring to the syslinux/loadlin type setup, rather 
than using lilo straight out off of a bootable partition.

> >Linux as a OS, has more kludge factor than anything else on the planet
> >and it works, people use it, life goes on.
> 
> I disagree

maybe not some versions, currently.  and maybe at some point it won't be
kludgy at all.  but what's more kludgy, BootX or a small HFS partition that
nobody knows is there?  parts of linux *are* still kludgy; this is true.  I
disagree with the assertation that it is "more kludgy than anything else 
on the planet," but i'd prefer it to be ugly and work than beautiful and 
useless.

> unless you keep an old crufty HFS partition laying around wasting 
> space to boot.

a machine running ODS does the same thing to store metadevice info; if you're 
booting off of a metadevice, (and god only knows why you would be, but it happens
a lot) you're doing the same thing.  i've seen a lot of machines that could
hardly called kludgy using this setup exactly.  the point is simply that if it
works, it works, and it makes the machine run better in the long run, it's better
than nothing at all, and certainly better as a "for-now" fix.  i really don't 
think that there is a huge performance/storage space issue at stake; i mean, we're
not talking about booting a commodore 64 here.  it really seems that this is 
an ugly vs. not ugly debate, and purely academic, as there are no other choices.

> the bootstrap process should have NO reliance on a specific filesystem!

and the more vehemently you criticize, the more people are expecting to see
you post a workaround that meets your aesthetic standards.

I agree with you in principle, but I thought the point was to come up with 
a functional booter rather than simply flame apple...  if we were just here
to flame operating system manufacturers, this would be a radically different
list.  :)

-- 
erik cameron  unix systems administrator
jfi/mrsec @ the university of chicago
e-cameron@uchicago.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
