Date: Tue, 1 Apr 2003 14:58:00 -0700
From: Matt Porter <porter@cox.net>
To: Khai Trinh <kqtrinh@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ibm_ocp_enet.c
Message-ID: <20030401145759.A29074@home.com>
References: <20030401213336.71765.qmail@web11501.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030401213336.71765.qmail@web11501.mail.yahoo.com>; from kqtrinh@yahoo.com on Tue, Apr 01, 2003 at 01:33:36PM -0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Apr 01, 2003 at 01:33:36PM -0800, Khai Trinh wrote:
>
> Hi folks,
>
> I am reading through the PPC ethernet driver source
> trying to locate the receive routine a ethernet
> packets from the PHY. All I saw was the
> ppc405_enet_start_xmit(). Where is the receive one?
>
> Would someone knowledgable in PPC ethernet driver give
> me a pointer or two?

ppc405_eth_rxeob() -> ppc405_rx_clean()

--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
