Message-ID: <8D4C69676E66D511A1CB00508BBBB192011C9F03@ranmx1.ran.harris.com>
From: "Fend, Matthias" <mfend@harris.com>
To: "'Jacky Wang'" <jacky@premierme.com.tw>, boehringer@snom.de
Cc: May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: AW: I need help getting pcmcia working with a FADS board
Date: Wed, 24 Apr 2002 07:23:38 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


if we talk about  m8xx_pcmcia_kernel-2.4.-19pre6.patch the patch does this:

- add the file m8xx_pcmcia.c into your kernel driver tree ( ...
/drivers/pcmcia/m8xx_pcmcia.c )
- add a entry for the new file into Config.in
- add a entry for the new file into Makefile

thats all

the patch was made from linuxppc_2_4_devel - but you can do these few changes
manually...

matthias

> -----Ursprüngliche Nachricht-----
> Von:	Jacky Wang [SMTP:jacky@premierme.com.tw]
> Gesendet am:	Mittwoch, 24. April 2002 12:51
> An:	boehringer@snom.de
> Cc:	May Ling List
> Betreff:	RE: I need help getting pcmcia working with a FADS board
>
>
> Sven,
>
> what does it patch for?
> 	which kernel source?
> 	or which pcmcia-cs source?
>
> Jacky
>
> > -----Original Message-----
> > From: owner-linuxppc-embedded@lists.linuxppc.org
> > [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of
> > Sven Boehringer
> > Sent: Tuesday, April 23, 2002 2:26 PM
> > To: Jacky Wang
> > Cc: May Ling List
> > Subject: Re: I need help getting pcmcia working with a FADS board
> >
> >
> > Hi Jacky,
> >
> > Matthew provided me with a patch for getting the pcmcia working.
> > I still have not enough time to test that patch. Here it goes:
> >
> >
> > Regards,
> >
> > 	Sven
> >
> >
> > Jacky Wang wrote:
> > >
> > > Hi everyone,
> > >
> > > I need help getting pcmcia working with a FADS board.
> > >
> > > Did someone finish the driver?
> > > If Yes, would you mind to share it with me?
> > >
> > > Jacky
> > >
> >
> >
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
