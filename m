Message-ID: <3C151516.B42EB547@mvista.com>
Date: Mon, 10 Dec 2001 12:03:34 -0800
From: Armin Kuster <Darth_vapor@mvista.com>
MIME-Version: 1.0
To: Felix Radensky <felix@allot.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppc405_enet problems
References: <3C14B86D.726DBDE6@allot.com> <20011210161702.GE22045@cpe-24-221-152-185.az.sprintbbd.net> <3C14F742.A922C291@allot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Felix Radensky wrote:
>
> Hi,
>
> Support for DP83846A is already present in drivers/net/ppc405_phy.c
> My guess is that phy reading fuctions are misbehaving, since i keep
> getting different values of Phy id on each boot.
>
> Felix.
>
Felix,

 try increasing in the "udelay(10)" in the  fec_enet_mdio_read

--armin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
