Date: Mon, 10 Dec 2001 09:17:02 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Felix Radensky <felix@allot.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppc405_enet problems
Message-ID: <20011210161702.GE22045@cpe-24-221-152-185.az.sprintbbd.net>
References: <3C14B86D.726DBDE6@allot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3C14B86D.726DBDE6@allot.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Dec 10, 2001 at 03:28:13PM +0200, Felix Radensky wrote:
>
> Hi,
>
> I'm trying to run the latest linuxppc_2_4_devel kernel on
> our custom 405GP based board. I get kernel panic when an
> attempt is made to probe for ethernet controller phy:
>
> Kernel panic: eth0: PHY id 0xfbc85c20 is not supported!
>
> The phy is National Semiconductor DP83846AVHG.
> It works fine with Monta Vista HHL 2.0 kernel.

IIRC, the hhl 2.0 kernel assumes that you have a National Semiconductor
DP83843.  I'm guessing the 83846 is similar enough such that it just
works.  Take a look at drivers/net/ppc405_phy.c, and add in support for
your PHY (and please sumbit a patch to the list).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
