Message-ID: <C060DFCD9697A842B3189B458524FDC206BFB5@AIMAIL1.ai.aiinet.com>
From: "Dayton, Dean" <deand@aiinet.com>
To: "'Pantelis Antoniou'" <panto@intracom.gr>,
	"Dayton, Dean" <deand@aiinet.com>
Cc: "'Adisorn Ermongkonchai'" <aermongk@yahoo.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: Poor 8260 FCC Ethernet performance
Date: Mon, 7 Jun 2004 08:32:44 -0400 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Your not being a complete ass;) I believe you. I also suspect that you have
a highly optimized data path and drivers, probably in cache, and probably
not using interupts. I also suspect that you are not saturating it with
minimum size (64 byte) packets.

BTW, the numbers I quoted earlier are roughly the same whether I use the FCC
ethernets or PCI tulip ethernets.

Dean Dayton

> Just to be a complete ass a 66MHz MPC885 with two FECs operating as a
> virtual switch is able to keep two 100MBits ports fully saturated. So
> I think that the hardware can certainly handle it.
>
> Not under linux though.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
