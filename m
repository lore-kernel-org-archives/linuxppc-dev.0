Date: Fri, 7 Jul 2000 18:14:09 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Hollis Blanchard <hollis@amulet.co.jp>
cc: Tom Gall <tom_gall@vnet.ibm.com>, yellowdog-devel@lists.yellowdoglinux.com,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: RFC: Changing default partition type for linux/ppc
In-Reply-To: <3965DC16.7CB143B3@amulet.co.jp>
Message-ID: <Pine.LNX.4.10.10007071754400.28685-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > > So I suggest moving to Linux_ext2, Linux_swap, or maybe simply Linux and
> > > Linux_swap (since ext2 is not the only filesystem Linux may put on
> > > these). Using a different type for swap would help avoiding confusion.
> >
> > I agree. I think this is a good step. However there's the obvious interoperability
> > problems with MacOS, OS X etc... Hopefully Apple's OSes wouldn't do anything evil
> > to the partition they don't recognize.
>
> Well, they don't at this point. For example in partitioning tool in
> LinuxPPC 2000, LinuxPPC Inc decided it would be better to use the type
> "Linux_PPC". This works (in that nothing gets overwritten, corrupted,
> etc) but has the disadvantage that no other software knows anything
> about that type.

So can we get all distributions to agree on this partition type scheme?
IIRC Debian currently relies on the Apple_Unix_SVR2 type, and ignores
everything else for the purpose of installing or creating swap space. I'd
like to update the Debian version of pdisk to recognize types used by
other distributions if possible.
LinuxPPC 1999 used the same type, and I think the 2000 change is a bad
thing. What are YellowDog and SuSE using?

Plus I don't think Apple cares too much, they may currently ignore strange
partition types but decide to nuke them tomorrow.

Benh: are you maintaining the official version of pdisk now?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
