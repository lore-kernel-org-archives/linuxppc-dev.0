Mime-Version: 1.0
Message-Id: <v04210104b40612fb095b@[192.168.0.1]>
In-Reply-To: <19990915181524.C10558@senta.uchicago.edu>
References: <19990915113905.031280@mailhost.mipsys.com>
 <v04210108b4051bfbea54@[192.168.0.1]>
 <v04210103b4058cbb5883@[17.203.21.242]>
 <v04210102b405ce2cdefb@[192.168.0.1]>
 <19990915181524.C10558@senta.uchicago.edu>
Date: Wed, 15 Sep 1999 19:50:57 -0800
To: erik cameron <cameron@senta.uchicago.edu>
From: Ethan Benson <erbenson@alaska.net>
Subject: Re: New booter
Cc: Kevyn Shortell <kevyn@apple.com>, Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 15/9/99 erik cameron wrote:

>i think people were referring to the syslinux/loadlin type setup, rather
>than using lilo straight out off of a bootable partition.

BOTH options should be available, for some syslinux/loadlin is more 
convenient, for others LILO is a much nicer solution, especially in 
its ability to load an arbitrary OS it knows nothing about by simply 
loading that OSes bootblock!

> > I disagree
>
>maybe not some versions, currently.  and maybe at some point it won't be
>kludgy at all.  but what's more kludgy, BootX or a small HFS partition that
>nobody knows is there?  parts of linux *are* still kludgy; this is true.  I
>disagree with the assertation that it is "more kludgy than anything else
>on the planet," but i'd prefer it to be ugly and work than beautiful and
>useless.

Linux does have kludges, I do not deny that, but for the most part 
the kludges are unavoidable, and often accompanied by very colorful 
comments in the source leading to censorship issues in australia :-)

the point it Linus and most linux developers PREFER to do things 
right, to implement the cleanest and most efficient way that can be 
done, but often times hardware makers leave stupid bugs in or create 
a shortsighted design that simply does not work well in the long term 
or does not work well outside of the small context the maker had in 
mind, those are places where linux has to kludge its way in, but its 
not prefered and only done if there is no other option.

my objections are twofold:

1) I want ALL avenues of true OF booting by way of the bootblock to 
be explored before giving up and implementing the second best 
alternative, which is partitions and fake macos et al.
2) I am simply very frustrated that apple is being so shortsighted in 
its design of OF and its boot process, they make it so specific to 
MacOS they themselves have challenges getting OSX to boot on their 
own machines! and later on HFS+ will be a obsolete filesystem and 
they will want to replace it again the desisions to make the boot 
process so dependant on HFS is going to haunt them as much as it 
gives migraines to developers of alternative OSes.

> > unless you keep an old crufty HFS partition laying around wasting
> > space to boot.
>
>a machine running ODS does the same thing to store metadevice info; if you're
>booting off of a metadevice, (and god only knows why you would be, 
>but it happens
>a lot) you're doing the same thing.  i've seen a lot of machines that could
>hardly called kludgy using this setup exactly.  the point is simply that if it
>works, it works, and it makes the machine run better in the long 
>run, it's better
>than nothing at all, and certainly better as a "for-now" fix.  i really don't
>think that there is a huge performance/storage space issue at stake; 
>i mean, we're
>not talking about booting a commodore 64 here.  it really seems that this is
>an ugly vs. not ugly debate, and purely academic, as there are no 
>other choices.

I am not yet convinced there are no other options, the options have 
hardly been explored, if there is indeed NO POSSIBLE WAY IN HELL to 
boot these machines without a partition hack then fine, but I am not 
yet satisfied we are to that point, I have been spending alot of time 
investigating this myself, but everytime i try and enlist any 
assistence to explore the issue further everyone seems to just say 
`use bootx' or `just make a kludge partition'  those options are fine 
for some situations and if fixing quik is indeed futile, but I just 
want to make SURE there is not a BETTER way!

> > the bootstrap process should have NO reliance on a specific filesystem!
>
>and the more vehemently you criticize, the more people are expecting to see
>you post a workaround that meets your aesthetic standards.

I have already stated several times how I think the boot process 
should be designed so that it can be truely filesystem agnostic and 
allow a LILO like system with all the niceties like password 
protection, multibooting, multiple images, all in a nice clean 
asthetically pleasing way.

I have also been doing as much research as I get get ahold of on OF 
and Apple's implementation of it, and tinkering with it and quik, 
trying to find a working solution that satisfies my high standards.

>I agree with you in principle, but I thought the point was to come up with
>a functional booter rather than simply flame apple...  if we were just here
>to flame operating system manufacturers, this would be a radically different
>list.  :)
>
>--

I am not here to flame apple, I am very frustrated with them because 
its ultimately their [shortsighted] design that is forcing all these 
messy boot methods, its even causing them headaches in trying to get 
OSX[S] to boot.

I want to come up with more then a simply `functional' booter I want 
to end up with a clean efficient and asthetically pleasing booter.  I 
at least want to TRY, but I cannot do it alone!



Best Regards,
Ethan Benson
To obtain my PGP key: http://www.alaska.net/~erbenson/pgp/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
