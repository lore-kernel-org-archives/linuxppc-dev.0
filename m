Date: Tue, 7 Sep 1999 08:55:06 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Troy Benjegerdes <hozer@drgw.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ioremap (still?) broken
In-Reply-To: <Pine.LNX.4.04.9909070126490.14821-100000@narn.drgw.net>
Message-ID: <Pine.LNX.4.10.9909070854420.10344-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 7 Sep 1999, Troy Benjegerdes wrote:
> I am attempting to make an Alteon based Gigabit Ethernet card work in a
> Yosemite G3, and it appears that either ioremap is not mapping memory
> correctly, or the implementation of 'readl,writel' on PPC is not
> consistent with the implementation on all other architectures.

Paul just checked in an ioremap() fix at the linux_2_2 branch of vger.

Greetings,

						Geert

--
Geert Uytterhoeven ----------------- SONY Suprastructure Center Europe (SUPC-E)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Phone +32-2-7248608 Fax +32-2-7242686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
