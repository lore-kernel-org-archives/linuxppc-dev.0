Date: Sun, 28 May 2000 16:23:02 +0200 (MET DST)
From: Henning Loeser <Henning.Loeser@Physik.Uni-Marburg.DE>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ide_dmaproc - YaBoot
In-Reply-To: <20000528135238.30201@192.168.1.10>
Message-ID: <Pine.OSF.4.02.10005281617330.24781-100000@ax1305.physik.uni-marburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 28 May 2000, Benjamin Herrenschmidt wrote:
> Currently, yaboot will only work on "newworld" type machines. You won't
> be able to use it on a 7500. Can you veryfy that bus master is correctly
> enabled for your card in the PCI command register ?)
How do I do that?
lspci -vvx says :
[snip]
Control: I/O+ Mem- BusMaster+ [snip]
Is that it? If I can believe that I would say bus master is enabled, but
is it enabeled correctly ?????

--
Hi! I'm a .signature virus! Copy me into your ~/.signature to help me
spread!
--------------------------------------------------------------------------
Henning Loeser					      Fachbereich Physik
email: henning.loeser@physik.uni-marburg.de	      AG Oberflaechen
						      Philipps-Uni Marburg


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
