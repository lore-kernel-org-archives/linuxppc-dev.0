Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id AD8FCDDEC8
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 05:35:58 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so3870785wag
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 12:35:57 -0700 (PDT)
Message-ID: <fa686aa40709281235o286bf3e0qad92b893a4d63a9e@mail.gmail.com>
Date: Fri, 28 Sep 2007 13:35:57 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [PATCH 02/18] Add Kconfig macros for Xilinx Virtex support
In-Reply-To: <46FD45FA.3000205@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
	<20070928181558.18608.23527.stgit@trillian.cg.shawcable.net>
	<46FD45FA.3000205@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 9/28/07, Scott Wood <scottwood@freescale.com> wrote:
> Grant Likely wrote:
> > From: Grant Likely <grant.likely@secretlab.ca>
> >
> > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> > ---
> >
> >  arch/powerpc/platforms/40x/Kconfig |   30 +++++++++++++++++-------------
> >  1 files changed, 17 insertions(+), 13 deletions(-)
> >
> > diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
> > index c3dce3b..1aae0e6 100644
> > --- a/arch/powerpc/platforms/40x/Kconfig
> > +++ b/arch/powerpc/platforms/40x/Kconfig
> > @@ -61,13 +61,14 @@ config WALNUT
> >       help
> >         This option enables support for the IBM PPC405GP evaluation board.
> >
> > -#config XILINX_ML300
> > -#    bool "Xilinx-ML300"
> > -#    depends on 40x
> > -#    default y
> > -#    select VIRTEX_II_PRO
> > -#    help
> > -#      This option enables support for the Xilinx ML300 evaluation board.
> > +config XILINX_VIRTEX_GENERIC_BOARD
> > +     bool "Generic Xilinx Virtex board"
> > +     depends on 40x
> > +     default y
> > +     select VIRTEX_II_PRO
> > +     select VIRTEX_4_FX
> > +     help
> > +       This option enables generic support for Xilinx Virtex based boards.
>
> I don't think we want default y here.

I just followed the lead of Walnut here.  Perhaps for the embedded
targets all of them should be 'default n'.  Josh, thoughts?

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
