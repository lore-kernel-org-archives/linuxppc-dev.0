Date: Mon, 14 Jul 2003 13:49:27 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Roland Dreier <roland@topspin.com>
Cc: Paul Mackerras <paulus@samba.org>,
	Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ethernet PHY chip discovery not working on 855T with 971/972 chips
Message-ID: <20030714134927.A2543@home.com>
References: <3F0C8112.5060001@earthlink.net> <20030709212145.49E24C6D82@atlas.denx.de> <20030711151834.GU17433@ip68-0-152-218.tc.ph.cox.net> <3F0F468F.1050909@earthlink.net> <16143.24034.31805.589402@cargo.ozlabs.ibm.com> <3F117F3C.7090008@embeddededge.com> <52ptkewfu2.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52ptkewfu2.fsf@topspin.com>; from roland@topspin.com on Sun, Jul 13, 2003 at 09:29:09AM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sun, Jul 13, 2003 at 09:29:09AM -0700, Roland Dreier wrote:
>
>     Paul> .... It's a bit disappointing that 8xx still doesn't compile
>     Paul> in 2.5.  I don't have any 8xx hardware to test on so I have
>     Paul> been relying on others to update it.
>
> Speaking of 2.5, since our custom boards are in production now, I have
> an Ebony (440GP eval board) that is completely idle, and some free
> hacking time.  Is there any 4xx work that I could help with?  Is

A 44x thing that would be nice is to abstract the PCI-X bridge support
into a common call (or calls) so it can be configured into a variety
of windowing modes...like alternative monarch memory maps or any
non-monarch configurations.  Part of this would work would require that
fixup_bigphys_addr() be made aware of these window changes.  In addition
it would be nice to have a helper function that sets the same values as
the current hardcoded monarch configuration via the new abstracted
interface since that is a common configuration.

Sorry, but you asked. :)

> linuxppc-2.5 the right tree to use?

Yes, nothing 44x-related should be going in without a 2.5 patch.
I've invested considerable time making sure that it was usable
by other developers on 44x...hopefully that still the case after
two weeks of vacation.

Regards,
--
Matt Porter
mporter@kernel.crashing.org

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
