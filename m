From: "Georg Klug" <gklug@giga-stream.de>
To: <philippe.villet@acterna.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: AW: ppc405_phy.c : Slow NFS access with DP83846A ethernet controller
Date: Thu, 11 Jul 2002 16:00:17 +0200
Message-ID: <FFECLICFNBJAHONLGAKMGEEGCFAA.gklug@giga-stream.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <C1256BF2.00591EE2.00@magnus.eni.wago.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Phil,

> We are booting linux MVL2.1 on our custom board but NFS access are very slow.
> Our board is very close to the Walnut one except the ethernet controller (PHY)
> We are using a  DP83846A instead of DP83843 on the walnut.
> ...
> Any idea ?


>From the log you attached it looks like the Ethernet controller views the
network
as half duplex, which might cause problems, if the other side sees it as full
duplex.
You should probably check whether this matches your network set-up.

Georg


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
