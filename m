Date: Tue, 9 Apr 02 13:05:42 PDT
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0204092005.AA24074@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Incoming to helium.harhan.org:/home/linuxppc/linuxppc_2_4_alt
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini <trini@kernel.crashing.org> wrote:

> Taking debian as an example here.  You certainly wouldn't stick a zImage
> for every board into 1 package.

Exactly, which is why I never liked that idea.

> So you only 'win' if you have a common, _bootable_ image on all of these
> boards.

Yes.

> And while it is possible that there could be a common
> firmware, I'm not holding my breath. :)

When I go to Debian with this, I'll be asking for a ppcstar subarch to join to
the ranks of apus, chrp, powermac, and prep. All HEC PPC boards will be
PPCStar-compliant. If another manufacturer wants Debian support, they'll have
to address Debian themselves and decide for themselves if they want to
standardize their boot mechanism to make their request more acceptable.

> And the other point is that this makes it less clean to add in a new
> board port.

No, it's perfectly clean, you just throw one more machine into the
CONFIG_GENERIC_PPC32 framework.

> But what if they aren't really configurable?

They may not be configurable on a given board, but they are configurable given
an infinite number of boards.

> You could turn off
> CONFIG_PCI, but I don't think you'd get too far on most[1] systems.

Before I got fired from SBS I was getting ready to work on their new PPMC
boards which have GT-64260 instead of CPC700. While the old ones were only
practically usable as a monarch on a carrier board with useful PCI peripherals
like Ethernet, mass storage, etc. on the new ones they used GT-64260 Ethernets
and on-board IDE (flash disk) on the GT's device bus. This makes those boards
usable as independent computing engines in non-monarch mode where the PCI bus
doesn't belong to them and basically doesn't exist as far as they are
concerned. And those were normal 750CXe and 750FX boards, not 8xx or other very
very embedded stuff.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
