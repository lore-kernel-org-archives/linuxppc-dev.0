Message-ID: <39AF1096.70626495@embeddededge.com>
Date: Thu, 31 Aug 2000 22:12:38 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Platform configuration (was: Re: CONFIG_PPC != Mac)
References: <39AE80BD.D86B34DA@embeddededge.com> <Pine.HPX.4.10.10008311808260.15978-100000@gra-ux1.iram.es> <20000831184447.D3823@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:

> Here's a few: The PCI resource allocation/conflict stuff has "issues" with
> some Pmacs (7600, Yikes! G4, I don't know about others).

Geeze, don't even go there.  I have some really cool multimedia boards
I have been trying to use for months in my G4.....after lots of
resource conflict messages I discover my USB has been "reallocated"
to the bit bucket.....I would like to do some FireWire, but those are
PCI devices, too.  I haven't tried my 2940 SCSI lately, although I
suspect it is more of a driver problem than PCI related.  Works great
in 2.2, crashes downloading microcode in 2.4.  I am trying to collect
useful information and make sense of this, but I am having trouble
grasping all of the changes in the software and the configuration of
some of the G4 hardware.

It seems all of the standard stuff works OK, so I will just put these
projects aside for a while.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
