Message-ID: <20021017075647.54441.qmail@web13114.mail.yahoo.com>
Date: Thu, 17 Oct 2002 08:56:47 +0100 (BST)
From: =?iso-8859-7?q?John=20Nikiforos?= <ppclinuxuser@yahoo.gr>
Subject: RE: Problem with MPC8260 buffer descriptor
To: acurtis@onz.com, Dominique Letty <dletty@interfaceconcept.com>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <NCBBIINEHIPFGJPLBEIFKEICDNAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-7
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Is the ECE bit enabled?
(Cache coherency for the 8260, so that the
CPM wont get any stalled data)

                    John

 --- Allen Curtis <acurtis@onz.com> έγραψε: >
> > Now I try to port this driver under Linux 2.4.17
> Kernel for a MPC8260. I
> > have allocated
> > Buffer Descriptors in DPRAM and Data Buffers in
> SDRAM. When I try
> > to send a
> > buffer, I fill
> > a data buffer and the first BD registers, I think,
> with the
> > correct values.
> > It doesn't work
> > anytimes. When the buffer is transmited, the
> sending data are correct. The
> > problem seems to
> > come from the CPM which can't access to the BD
> modifications in the DPRAM.
> >
> > Does anyone have already meet these problems?
>
> Would it be a problem to post your:
>
> 1. GSMRH & GSRM_L initialization
> 2. SCC Parameter RAM configuration
> 3. Location of your BDs in DPRAM
>
> THX
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
