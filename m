Message-ID: <20001024111608.B11739@saw.sw.com.sg>
Date: Tue, 24 Oct 2000 11:16:08 +0800
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Hai-Pao Fan <haipao@mvista.com>,
        "ZHANG,HAI-TAO Non-A-China,ex1\"" <hai-tao_zhang@non.agilent.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: root filesystem over nfs
References: <2F67A63DFFB1D31185D90090278CBB2D017D2A39@apmail6.chn.agilent.com> <39F4A4B1.6EC2B309@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <39F4A4B1.6EC2B309@mvista.com>; from "Hai-Pao Fan" on Mon, Oct 23, 2000 at 01:50:57PM
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

On Mon, Oct 23, 2000 at 01:50:57PM -0700, Hai-Pao Fan wrote:
> This is one of the changes I made in eepro100.c for the ppc 4xx system. I think
> the maintainer should know this also.
>
>
> "ZHANG,HAI-TAO (Non-A-China,ex1)" wrote:
>
> > Hi,
> >
> > I tried to change one line in eepro100.c and now the 2.4.0-test9 boot is ok.
> >
> > $ diff eepro100.c eepro100.c.orig
> > 1098c1098
> > <       outl(TX_RING_ELEM_DMA(sp, sp->dirty_tx % TX_RING_SIZE),
> > ---
> > >       outl(cpu_to_le32(TX_RING_ELEM_DMA(sp, sp->dirty_tx % TX_RING_SIZE)),

yes, of course.
Thank you for the notice.

Best regards
			Andrey

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
