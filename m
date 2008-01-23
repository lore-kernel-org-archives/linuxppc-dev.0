Return-Path: <henk.stegeman@gmail.com>
Message-ID: <ae4f76fd0801230307ncf1b296y1e90444f0ee53504@mail.gmail.com>
Date: Wed, 23 Jan 2008 12:07:52 +0100
From: "Henk Stegeman" <henk.stegeman@gmail.com>
To: Linuxppc-embedded@ozlabs.org
Subject: How to support removable CF card via IDE on MPC52xx
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_28092_17427543.1201086472525"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_28092_17427543.1201086472525
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have IDE working on my MPC5200B based system using the driver:

drivers/ide/ppc/mpc52xx_ide.

The IDE device is a compact flash card inserted in a compact flash slot on
the CPU board. Two separate pins (reset and card-detect) are provided to the
CPU to force a reset and to detect the presence of the compact-flash card.

Right now I don't use the card detection, the card is always in the slot,
but I want to be able to use the board without the card inserted.

What is the best way to let the kernel only use the compact flash card when
it is inserted?

Can/should I make use of PCMCIA, eventhough the interface is not PCMCIA
compatible? Can PCMCIA then make use of the allready working
drivers/ide/ppc/mpc52xx_ide driver?

Thanks in advance,

Henk Stegeman

------=_Part_28092_17427543.1201086472525
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have IDE working on my MPC5200B based system using the driver:<br><br>drivers/ide/ppc/mpc52xx_ide.<br><br>The IDE device is a compact flash card inserted in a compact flash slot on the CPU board. Two separate pins (reset and card-detect) are provided to the CPU to force a reset and to detect the presence of the compact-flash card.
<br><br>Right now I don&#39;t use the card detection, the card is always in the slot, but I want to be able to use the board without the card inserted. <br><br>What is the best way to let the kernel only use the compact flash card when it is inserted?
<br><br>Can/should I make use of PCMCIA, eventhough the interface is not PCMCIA compatible? Can PCMCIA then make use of the allready working drivers/ide/ppc/mpc52xx_ide driver?<br><br>Thanks in advance,<br><br>Henk Stegeman
<br><br>

------=_Part_28092_17427543.1201086472525--
