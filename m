Date: Fri, 12 Dec 2003 07:45:41 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Stefan Roese <stefan.roese@esd-electronics.com>
Cc: "'DaveyWu'" <daveywu@transengines.com>,
	"'Linuxppc-Embedded'" <linuxppc-embedded@lists.linuxppc.org>,
	benh@kernel.crashing.org, akuster@mvista.com
Subject: Re: PPC4xx enet driver problem (version 2.0)
Message-ID: <20031212074541.A32360@home.com>
References: <01b001c3c059$35107840$5100a8c0@davey033ce6193> <004601c3c09e$8cfea410$0212000a@PCSTEFAN>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <004601c3c09e$8cfea410$0212000a@PCSTEFAN>; from stefan.roese@esd-electronics.com on Fri, Dec 12, 2003 at 11:56:09AM +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Dec 12, 2003 at 11:56:09AM +0100, Stefan Roese wrote:
>
> Davey!
>
> No, we didn't solve this problem so far. Eugene did some tests on an
> ppc440 board and had no problems with the multiple enet devices. So it
> seems to be 405ep related! I still have to send some debug output to
> Eugene (hopefully today)!

[I haven't followed the thread but new EMAC driver and 405EP rings
 a bell]

It's possible that the new method in which OCP code handles OCP device
dependencies has a bug.  405ep is a special case since it requires
a particular EMAC device to provide MDIO operations for both EMACs.
440gp/gx don't follow this code path.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
