Message-ID: <406C4A26.3040107@embeddededge.com>
Date: Thu, 01 Apr 2004 11:58:14 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Wolfgang Denk <wd@denx.de>, Kumar Gala <kumar.gala@motorola.com>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: mpc5xxx support (Was: Re: Proposed Kconfig update patch for help
 text)
References: <67423B18-83E3-11D8-B6FB-000393DBC2E8@motorola.com> <20040401150211.90D85C10A4@atlas.denx.de> <20040401161622.GA26876@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:

> In all seriousness, when the 52xx code for 2.4 was brought up, there
> were a number of objections to the Motorola provided code,

Does anyone actually use this code?  From the work I've done it appears
the FEC implements it's own DMA, other peripherals are used in programmed I/O
mode, and stuff I have done I've found it easier to just write my own
code manage the DMA.  IMHO we should just punt this stuff for Linux,
now that there is more public interest start collaborating on a better
solution, and maybe just use what Mot provided as documentation filler.
The Motorola solution seems like an attempt to be everything for everyone.

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
