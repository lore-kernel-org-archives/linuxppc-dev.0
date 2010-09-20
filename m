Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 48EC9B6EED
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Sep 2010 07:31:31 +1000 (EST)
To: Tirumala Marri <tmarri@apm.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 1/2] PPC4xx: Generelizing drivers/dma/ppc4xx/adma.c
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <7707889dee57e97ad50b4ce5c7697466@mail.gmail.com>
References: <1284774145-14543-1-git-send-email-tmarri@apm.com>
	<20100918210920.E05AE157D71@gemini.denx.de>
	<7707889dee57e97ad50b4ce5c7697466@mail.gmail.com>
Date: Mon, 20 Sep 2010 23:31:26 +0200
Message-Id: <20100920213126.0A1B1157D71@gemini.denx.de>
Cc: neilb@suse.de, yur@emcraft.com, linux-raid@vger.kernel.org,
	herbert@gondor.hengli.com.au, linux-crypto@vger.kernel.org,
	dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Tirumala Marri,

In message <7707889dee57e97ad50b4ce5c7697466@mail.gmail.com> you wrote:
>
> > > +/**
> > > + * ppc440spe_can_rxor - check if the operands may be processed with RXOR
> > > + */
> > > +static int ppc440spe_can_rxor(struct page **srcs, int src_cnt,
> > size_t len)
> >
> > Again, should this then not be in ppc440spe specific files?
> >
> >
> > It seems the split / generalization is highly incomplete yet.
> 
> [Marri] Some of the stuff can go into ppc440spe-dma.h. This is just
> Beginning to add more new DMA engines support. I expect more changes to
> come in.

Why would that go into a header file? This is source code, not header
stuff. It should stay in a .c file!  [Note that Ilya asked the same
question.]

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Intel's new motto: United we stand. Divided we fall!
