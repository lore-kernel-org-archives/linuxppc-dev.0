To: Matt Porter <mporter@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>,
	Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ethernet PHY chip discovery not working on 855T with 971/972 chips
References: <3F0C8112.5060001@earthlink.net>
	<20030709212145.49E24C6D82@atlas.denx.de>
	<20030711151834.GU17433@ip68-0-152-218.tc.ph.cox.net>
	<3F0F468F.1050909@earthlink.net>
	<16143.24034.31805.589402@cargo.ozlabs.ibm.com>
	<3F117F3C.7090008@embeddededge.com> <52ptkewfu2.fsf@topspin.com>
	<20030714134927.A2543@home.com>
From: Roland Dreier <roland@topspin.com>
Date: 14 Jul 2003 22:08:11 -0700
In-Reply-To: <20030714134927.A2543@home.com>
Message-ID: <5265m4v0lg.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


    Matt> A 44x thing that would be nice is to abstract the PCI-X
    Matt> bridge support into a common call (or calls) so it can be
    Matt> configured into a variety of windowing modes...like
    Matt> alternative monarch memory maps or any non-monarch
    Matt> configurations.  Part of this would work would require that
    Matt> fixup_bigphys_addr() be made aware of these window changes.
    Matt> In addition it would be nice to have a helper function that
    Matt> sets the same values as the current hardcoded monarch
    Matt> configuration via the new abstracted interface since that is
    Matt> a common configuration.

That sounds doable, although I'm not sure how to test any non-monarch
support given the systems I have available.  In any case I'll start
taking a look at the current 2.5 sources and try to come up with a
proposal for the right PCI-X abstraction.

 - R.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
