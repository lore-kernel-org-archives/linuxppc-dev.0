Message-ID: <20021017135003.23135.qmail@web13115.mail.yahoo.com>
Date: Thu, 17 Oct 2002 14:50:03 +0100 (BST)
From: =?iso-8859-7?q?John=20Nikiforos?= <ppclinuxuser@yahoo.gr>
Subject: RE: Problem with MPC8260 buffer descriptor
To: Dominique Letty <dletty@interfaceconcept.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <000e01c275da$33148ba0$3501a8c0@none>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-7
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 I don't remember if it is called ECE or ESE.
I think it is on the HID0. But I am not sure.
I currently don't have the manual handy.

                       John

 --- Dominique Letty <dletty@interfaceconcept.com>
έγραψε: >
> I don't find any information about this ECE bit in
> MPC8260UM and 603eUM.
> Where can I enable it?
>
> Thinks for your help.
>
> Dominique
> -----Message d'origine-----
> De : John Nikiforos [mailto:ppclinuxuser@yahoo.gr]
> Envoye : jeudi 17 octobre 2002 09:57
> A : acurtis@onz.com; Dominique Letty;
> linuxppc-embedded@lists.linuxppc.org
> Objet : RE: Problem with MPC8260 buffer descriptor
>
>
>  Is the ECE bit enabled?
> (Cache coherency for the 8260, so that the
> CPM wont get any stalled data)
>
>                     John
>
>  --- Allen Curtis <acurtis@onz.com> έγραψε: >
> > > Now I try to port this driver under Linux 2.4.17
> > Kernel for a MPC8260. I
> > > have allocated
> > > Buffer Descriptors in DPRAM and Data Buffers in
> > SDRAM. When I try
> > > to send a
> > > buffer, I fill
> > > a data buffer and the first BD registers, I
> think,
> > with the
> > > correct values.
> > > It doesn't work
> > > anytimes. When the buffer is transmited, the
> > sending data are correct. The
> > > problem seems to
> > > come from the CPM which can't access to the BD
> > modifications in the DPRAM.
> > >
> > > Does anyone have already meet these problems?
> >
> > Would it be a problem to post your:
> >
> > 1. GSMRH & GSRM_L initialization
> > 2. SCC Parameter RAM configuration
> > 3. Location of your BDs in DPRAM
> >
> > THX
> >
> >
> >
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
