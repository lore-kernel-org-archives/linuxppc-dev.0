Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9FDAB1A06BA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 01:57:30 +1100 (AEDT)
Message-ID: <1456844240.5360.65.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Alessio Igor Bogani <alessio.bogani@elettra.eu>
Cc: Kumar Gala <galak@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
Date: Tue, 01 Mar 2016 08:57:20 -0600
In-Reply-To: <CAPk1OjG8hFAtJM1wLFcTHCD1Ld9fKuvcZgKpuDZ1=o-_RQGXOw@mail.gmail.com>
References: <1456397825-1786-1-git-send-email-alessio.bogani@elettra.eu>
 <1456397825-1786-2-git-send-email-alessio.bogani@elettra.eu>
 <1456785480.5360.60.camel@buserror.net>
 <CAPk1OjG8hFAtJM1wLFcTHCD1Ld9fKuvcZgKpuDZ1=o-_RQGXOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [RFC PATCH v1 2/2] powerpc/86xx: Introduce and use common dtsi
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-03-01 at 15:55 +0100, Alessio Igor Bogani wrote:
> Scott,
> 
> On 29 February 2016 at 23:38, Scott Wood <oss@buserror.net> wrote:
> [...]
> > 
> > > +&pci0 {
> > > +     compatible = "fsl,mpc8641-pcie";
> > > +     device_type = "pci";
> > > +     #size-cells = <2>;
> > > +     #address-cells = <3>;
> > > +     bus-range = <0x0 0xff>;
> > > +     clock-frequency = <33333333>;
> > 
> > The clock frequency of PCI Express is not 33 MHz.
> 
> A lot of dtsi files into fsl directory have got that value!

Well, they shouldn't. :-P

This isn't the first time I've told someone to take that out.

-Scott
