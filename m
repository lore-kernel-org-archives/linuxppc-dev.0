Message-ID: <3BF5B6E1.5070200@embeddededge.com>
Date: Fri, 16 Nov 2001 20:01:21 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>,
	Matt Porter <mporter@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Organisation of 4xx initialization code
References: <20011116164625.K673@zax> <20011116045737.A24130@cx258813-a.chnd1.az.home.com> <20011116085121.D5410@cpe-24-221-152-185.az.sprintbbd.net> <20011116094210.B3473@beef.az.mvista.com> <20011116101323.B9242@cpe-24-221-152-185.az.sprintbbd.net> <3BF5A01D.4040502@embeddededge.com> <20011117114330.G12763@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:


> That's exactly my point:  platform_init() for *all* 4xx boards is in
> ppc4xx_setup.c, which then calls a board_init() function which comes
> from the particular board.

But, you missed my point.  I was implicating all PowerPC boards, not
just 4xx.  Before we jump off and proclaim it is _the_ way to handle
porting of the different boards, we better understand why it isn't
widely done today.  It seems only Matt does it for some of the boards
he has ported.  The platform_init() for _all_ 8xx boards is done
generically in m8xx_setup.c, which works fine for all of them we support
and it wouldn't make sense to have individual files for the dozens of
those that are supported.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
