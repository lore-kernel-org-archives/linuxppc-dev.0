Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqJCr2KDFzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 07:33:27 +1000 (AEST)
Message-ID: <1461101600.32510.207.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Alessio Igor Bogani <alessio.bogani@elettra.eu>
Cc: Kumar Gala <galak@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
Date: Tue, 19 Apr 2016 16:33:20 -0500
In-Reply-To: <CAPk1OjHbNZfcsGfmt_tyD=3YBcJaVYLvpExtVYWaSo=5jZb+sQ@mail.gmail.com>
References: <460384482-21320-1-git-send-email-alessio.bogani@elettra.eu>
 <1460966279-29188-1-git-send-email-alessio.bogani@elettra.eu>
 <1461039981.32510.201.camel@buserror.net>
 <CAPk1OjHbNZfcsGfmt_tyD=3YBcJaVYLvpExtVYWaSo=5jZb+sQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH v2 1/1] powerpc/86xx: Add support for Emerson/Artesyn
 MVME7100
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-04-19 at 10:33 +0200, Alessio Igor Bogani wrote:
> Hi Scott,
> 
> Thanks for reviewing it!
> 
> On 19 April 2016 at 06:26, Scott Wood <oss@buserror.net> wrote:
> > On Mon, 2016-04-18 at 09:57 +0200, Alessio Igor Bogani wrote:
> > > +     pci0: pcie@f1008000 {
> > > +             reg = <0xf1008000 0x1000>;
> > > +             ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0
> > > 0x50000000
> > > +                       0x01000000 0x0 0x00000000 0xf0000000 0x0
> > > 0x00800000>;
> [...]
> > > +
> > > +     pci1: pcie@f1009000 {
> > > +             compatible = "fsl,mpc8641-pcie";
> > > +             device_type = "pci";
> > > +             #size-cells = <2>;
> > > +             #address-cells = <3>;
> > > +             reg = <0xf1009000 0x1000>;
> > > +             bus-range = <0 0xff>;
> > 
> > Why are pci0 and pci1 so different? Why does mpc8641si-post.dtsi not have
> > pci1?
> 
> You are right. The MPC8641 processor offers two pci so
> mpc8641si-post.dtsi should be the right place where to define both.
> What about the boards which don't use the pci1? Will 'status =
> "disabled"' be enough?

Yes.

-Scott
