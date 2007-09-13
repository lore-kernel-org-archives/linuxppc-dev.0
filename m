Return-Path: <dan.j.williams@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.225])
	by ozlabs.org (Postfix) with ESMTP id 24F0EDDE22
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 02:25:58 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so505257wxd
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 09:25:58 -0700 (PDT)
Message-ID: <e9c3a7c20709130925s2234d652ne43bf44e204ac4e8@mail.gmail.com>
Date: Thu, 13 Sep 2007 09:25:57 -0700
From: "Dan Williams" <dan.j.williams@intel.com>
Sender: dan.j.williams@gmail.com
To: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
Subject: Re: [PATCH 5/5] Add DMA engine driver for Freescale MPC85xxprocessors.
In-Reply-To: <46B96294322F7D458F9648B60E15112C85D8A5@zch01exm26.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <11891624582950-git-send-email-wei.zhang@freescale.com>
	<20070907223553.GA18599@freescale.com>
	<46B96294322F7D458F9648B60E15112C85D8A5@zch01exm26.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org, shannon.nelson@intel.com, paulus@samba.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 9/13/07, Zhang Wei-r63237 <Wei.Zhang@freescale.com> wrote:
> Hi,
>
> > > +static void fsl_dma_set_src(dma_addr_t addr,
> > > +                           struct dma_async_tx_descriptor
> > *tx, int index)
> > > +{
> >
> > What is index supposed to mean?  It's not used, or documented
> > anywhere than
> > I can see.
>
> I've also got more document here. Hi, Dan, could you give me some
> explanation about this API? :)
>
The index field gets used for multi-source (or multi-dest) operations.
 XOR, for example, is a multi-source operation.  I am preparing a
documentation patch.

[..]

--
Dan
