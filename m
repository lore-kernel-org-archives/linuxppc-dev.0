Message-ID: <000e01c394c7$5e782240$6401a8c0@sazabimobile>
From: "Shih-Ying Chou" <sschou@mtu.edu>
To: "Jacky Lam" <jackylam@astri.org>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <001801c3946b$48d84390$6401a8c0@sazabimobile> <004501c39473$761a4990$2803050a@JackyLam>
Subject: Re: Problem with EP405's PCI 
Date: Fri, 17 Oct 2003 11:57:29 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thank you very much for your input.  I have read the previous post but it is
not very useful to me.
Because I am not using u-boot as my bootloader, since u-boot does not
support EP405 board.
I am using the Planet Core from Embedded Planet which does not do any
initialization on the PCI.

Does anyone have any other idea?

Thanks in advance

Shih-Ying Chou

----- Original Message -----
From: "Jacky Lam" <jackylam@astri.org>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Friday, October 17, 2003 1:56 AM
Subject: Re: Problem with EP405's PCI


>
>     Please see my previous post and the reply from xzuo@vinesystech.com .
> Hope it can help.
>
> Jacky
> ----- Original Message -----
> From: "Shih-Ying Chou" <sschou@mtu.edu>
> To: <linuxppc-embedded@lists.linuxppc.org>
> Sent: Friday, October 17, 2003 12:58 PM
> Subject: Problem with EP405's PCI
>
>
> >
> > Hi All,
> >     Have anyone successfully made the EP405's PCI (through PC/104 plus)
> > work?  If anyone does, please help me, I have struggle with it for over
a
> > month now.
> >     Right now I am using the linuxppc_2_4_devel kernel, and I can get
the
> > EP405 to boot successfully.  But I can get the PCI interface to work
> right.
> > When booting up, the kernel can recognize the card weither USB or Sound
> > card, but it can seem to assign the right irq to the card.  Because USB
> card
> > always complain about no IRQ assign and ask to check BIOS.
> >     I have look at the ep405.c and ppc405_pci.c and ppc4xx_pic.c files,
> but
> > I cannot find out what is wrong.  I know that I need to modify the
> > ppc405_devtable [] in the ep405.c file. I also check the registers such
as
> > DCRN_UIC_PR, DCRN_UIC_TR, and DCRN_UIC_SR and all the value seems to be
> > correct, except DCRN_UIC_PR.  In the ep405.c DCRN_UIC_PR is set to be
> > 0xffffff80 which makes the PCI interrupt to be high, so as the User
manual
> > stated.  But isn't PCI's interrupt should be active low?
> >
> > Any pointer will be helpful, thank you in advance!
> >
> > Shih-Ying Chou
> >
> >
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
