From: "Henry A. Worth" <haworth@ncal.verio.com>
Date: Thu, 30 Mar 2000 12:07:44 -0800 (PST)
Message-Id: <200003302007.MAA07408@ shell1.ncal.verio.com>
To: erbenson@alaska.net, linuxppc-dev@lists.linuxppc.org
Cc: haworth@verio.com
Subject: Re: LinuxPPC and Pismo Powerbook
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Argh, didn't add the maillist in my first response, so once again
from scratch.

> From: Ethan Benson <erbenson@alaska.net>

> On Wed, Mar 29, 2000 at 11:20:17AM -0800, Henry A. Worth wrote:
> >=20
> > I filled 32MB up quite easily with test kernels. Of course
> > normal users won't have that problem.  You should=20
> > leave enough room for several kernels so you can have a=20
> > basic rescue kernel and ramdisk, a good stable kernel, and=20
> > that spiffy new kernel that's going to mess everything up
> > and require you to use that rescue kernel. Also if you start
> > experimenting with the system folder approach you'll be dupping
> > yaboot and conf into the system folder.
> >=20

> kernels do not belong on the HFS boot partition, they belong on the
> ext2 root filesystem.  yaboot !=3D bootx it boots the kernels from ext2
> bootx does not.

That's interesting to know, I'd been wondering about that.

> >=20
> > Hm, didn't have that problem when I was using that.=20

A bit hard to boot off a root partition that doesn't exist, or
a CD that doesn't support your machine. Any good installation
is also going to have provisions for a rescue boot that doesn't
depend upon any of the Linux partitions. With floppies going the
way of the dodo, that usually means some form of boot partition.

In my case I also needed a setup that would allow me to use
MacOS to download test kernels until they worked reliably
enough to do a full install.

> some don't, when i worked on a similer project we would have multiple
> machines with the EXACT same OS version, one would consistently remove
> the blessing and boot blocks, the other hardly ever... =20

> > You shouldn't need the system folder nonsense if you also set boot-file.
> > Which is one of the nice things about this approach if a Linux-only
> > system.

> people hate messing with OF settings.  deal with it.  that is why i
> reccomend a non macos mountable bootstrap partition, with this
> configuration you do not need to touch OF.

I largely agree with you, but there are always alternative needs and
solutions.

> >=20
> > The problem I had with ybin (of course my perpective is someone=20
> > trying to debug support for a machine that will not boot and=20
> > install Linux yet), is that this has to be done from Linux.

> ybin is a linux utility.  macos does not provide the infrstructure for
> me to build something similer, it would require a C program, I am not
> a macos programmer and don't want to be. =20

> > It would be a lot more usefull if it was a MacOS tool

> it might be useful to have a macos tool but my goal is to eliminate
> the need to do everything from macos, also if you would read the web
> page it explains quite clealy that the point of ybin is to provide a
> quik/lilo like way to manage a bootstrap partition.  if that is not
> what you want then ybin is not for you.

Actually, ybin is probably a part of what I need, but I couldn't
determine that from Ben's link or your webpage.

> > or you at least had seperate docs, after downloading it I couldn't=20
> > unpackage it in MacOS and with no docs decided it wasn't worth=20

> tar.gz is hardly difficult to unpackage under macos.  lets leave the
> misinformation out please.  there IS docs in the ybin package, not as
> much as i would like, but 0.12 will have more. =20

The macgzip I downloaded would not unzip it, and I've seen other
complaints of the same. Probably not the latest version or IE
munged the download, but most potential users are not going
to spend their limited time debugging a tools packaging when they
have no reason to believe that tool is going to help them. That's
why enough seperate documentation is needed to know if this is
a must have and to be able to plan how and when it will be used.

> > the trouble to transfer to my x86 system to see what it consisted=20

> this is rubbish you don't need to transfer it to a intel system to
> unpack it.  you seem to think that macos is only capable of extracting
> stuffit archives.=20

Not at all, but there are limits to how much time I, or anyone else,
is going spend downloading tools for MacOs to support a utility that
they had not been convinced would be of use. I'm not interested in
MacOS or downloading a bunch of tools that I would only use once.
If it wasn't for DVD's, MacOS would have already been flushed from
my system as soon as I didn't need it to download kernels for testing.

> > of. Until someone produces some definitative consolidated=20
> > documentation for yaBoot and these other tools, so users can plan
> > ahead, they are already going to have their system repartioned and=20
> > have reinstalled MacOS and install Linux to find out they are going=20
> > to have to do it all over again, yeh...right.=20

> I happen to be working on documenting all of this, and am more then
> halfway there.  if you don't have a bootstrap partition then yes you
> have to repartition or keep things on your macos partition. ybin will
> allow you to install yaboot to a macos partition, but that
> configuration forces you to screw with OF and that is why i don't
> reccommend it.  i will not reccomend methods that require fscking with
> OF becuase i know people don't want that.

That's good news and badly needed, the two putative end-user
distributions have dropped the ball here. Since they are
the ones trying to make a buck pushing this on end users, I
view them as having the ultimate responsibility to throughly
document this stuff. With SUSE getting involved and some signs
that Mandrake is interested in PPC, there is hope for
improvement in that arena.

But any comprehensive document needs to cover all the options
and their pros and cons. Make your recommendations, but don't
forget that other users have different needs and biases. And
please make the document available seperate from your package
in plain text, HTML, or pdf. Wish I could help you, this is
badly needed, but until a few weeks ago I hadn't touched a
Mac in nearly a decade, and only have all the conflicting
opinions and facts I could glean, largely from these mailists,
to go by. I'd be happy to review your document if you'd like.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
