Date: Thu, 25 May 2000 20:10:21 +0200 (MET DST)
From: Henning Loeser <Henning.Loeser@Physik.Uni-Marburg.DE>
To: linuxppc-dev@lists.linuxppc.org
Subject: ide_dmaproc
In-Reply-To: <200005250459.XAA09785@lists.linuxppc.org>
Message-ID: <Pine.OSF.4.02.10005251944580.15015-100000@ax1305.physik.uni-marburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi
encouraged by Simon success with his Promise IDE card I went for
an other try with my AEC6260M ide card.
I patched a standart 2.2.15 kernel source with Andre's ide-patches (they
wouldn't install on Pauls rsynced stable tree) and after that applied
Michels pci-patches (the new ones), took a deep breath and rebooted, but
the error I allready told about (the AEC6260M message) prevailed :-(
I switched the cards around to find out whether it's the pci-slot ... no
success.
I keep getting errormassages stateing:
>ide_dmaproc: chipset supported ide_dma_lostirq func only: 11

the card and driver where detected and installed during boot :
>ide0 at 0xf2000840-0xf2000847,0x000 on irq 23

Any ideas on where I should start looking for the error?
Anyone some spare time to help me with this ??? :-(

Henning
--------------------------------------------------------------------------
Henning Loeser					      Fachbereich Physik
email: henning.loeser@physik.uni-marburg.de	      AG Oberflaechen
						      Philipps-Uni Marburg


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
