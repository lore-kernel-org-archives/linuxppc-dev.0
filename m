Message-ID: <001801c3946b$48d84390$6401a8c0@sazabimobile>
From: "Shih-Ying Chou" <sschou@mtu.edu>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Problem with EP405's PCI 
Date: Fri, 17 Oct 2003 00:58:19 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,
    Have anyone successfully made the EP405's PCI (through PC/104 plus)
work?  If anyone does, please help me, I have struggle with it for over a
month now.
    Right now I am using the linuxppc_2_4_devel kernel, and I can get the
EP405 to boot successfully.  But I can get the PCI interface to work right.
When booting up, the kernel can recognize the card weither USB or Sound
card, but it can seem to assign the right irq to the card.  Because USB card
always complain about no IRQ assign and ask to check BIOS.
    I have look at the ep405.c and ppc405_pci.c and ppc4xx_pic.c files, but
I cannot find out what is wrong.  I know that I need to modify the
ppc405_devtable [] in the ep405.c file. I also check the registers such as
DCRN_UIC_PR, DCRN_UIC_TR, and DCRN_UIC_SR and all the value seems to be
correct, except DCRN_UIC_PR.  In the ep405.c DCRN_UIC_PR is set to be
0xffffff80 which makes the PCI interrupt to be high, so as the User manual
stated.  But isn't PCI's interrupt should be active low?

Any pointer will be helpful, thank you in advance!

Shih-Ying Chou


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
