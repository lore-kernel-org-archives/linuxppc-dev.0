From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Jeglinski <jeglin@4pi.com>,
	<linuxppc-dev@lists.linuxppc.org>,
	Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: ethtool failure with tulip 21143
Date: Sun, 16 Dec 2001 19:25:08 +0100
Message-Id: <20011216182508.25208@smtp.wanadoo.fr>
In-Reply-To: <p04330105b8428baee0fe@[24.163.44.170]>
References: <p04330105b8428baee0fe@[24.163.44.170]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>I have a PowerPC 6500 with a Farallon 10/100 PCI card connected to a
>Netgear 10/100 switch. I have never gotten this card to work right in
>this box. If the number of packets is small, the connection seems to
>work, but any increase in the number of packets (my theory) causes
>the interface/NIC to choke up. I'm using 2.4.14 (bk).
>
>I downloaded Jeff Garzik's ethtool to work on this, but I'm hitting a
>brick wall rather rapidly. As per dmesg:

Jeff, afaik, this one has the broken bridge I told you about.


Stephan, I'll send you a hack to try out with de4x5 later today.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
