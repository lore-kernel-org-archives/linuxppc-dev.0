Message-ID: <3905CD51.90ED385B@wanadoo.fr>
Date: Tue, 25 Apr 2000 18:52:33 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Ethan Benson <erbenson@alaska.net>
CC: Daniel Gonzalez <daniel.gonzalez@pandora.be>,
        LinuxPPC Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Bye HFS partition?
References: <390516C2.1DD0D2D@pandora.be> <20000425010826.T7022@plato.localdomain.local>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ethan Benson wrote:
>
> On Mon, Apr 24, 2000 at 11:53:38PM -0400, Daniel Gonzalez wrote:
> >
> > Hi,
> >
> > I have just destroyed my hfs partition (I was trying to make
> > a directory there and ... oooops!)
>
> do you mean you ran into the general unreliablity of the kernel's HFS
> support?

I don't think that HFS support is *generally* unreliable. It works well
with 2.2.x kernels and is broken on recent 2.3.x kernels. From his
earlier posts I recall that Daniel is using a 2.3.99 kernel.

For me, mounting an HFS partition under a 2.3.99 kernel and doing more
than just a file listing leads to almost instant system freeze and
sometimes destruction of the HFS partition (I am trying this only on a
ZIP, so I can easily reformat). The oops I get comes, in general, from
the hfs_bnode_relse function in fs/hfs/bnode.c, where a waitqueue bug is
detected.

It would be nice (and rather vital for the survival of LinuxPPC under
the imminent (?) 2.4 kernel) if some LinuxPPC developers woke up to this
situation. (Seems to be above my capacities, sorry). The official
maintainer of the HFS code doesn't do much, and some developers (I
remember A Joshi and Tom Rini) gave the impression that they have a
working HFS filesystem under 2.3.x. In the todo list for kernel 2.4,
however, HFS is marked as broken (but no showstopper for the i386 crowd,
of course).

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
