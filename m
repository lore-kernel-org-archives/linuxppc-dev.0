Return-Path: <vitb@kernel.crashing.org>
Received: from vitb.dev.rtsoft.ru (unknown [85.21.88.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 711CFDDEEB
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 02:26:57 +1000 (EST)
Date: Tue, 8 May 2007 20:26:08 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: "Loeliger Jon-LOELIGER" <jdl@freescale.com>
Subject: Re: [PATCH 3/3] [POWERPC] dts: kill hardcoded phandles
Message-ID: <20070508202608.16c128a0@vitb.ru.mvista.com>
In-Reply-To: <AF0367BA48C55940A43CCF08DF35553C012AA472@az33exm24.fsl.freescale.net>
References: <20070508053049.18428.50622.stgit@localhost.localdomain>
	<20070508054855.18428.29080.stgit@localhost.localdomain>
	<20070508055431.GA21009@localhost.localdomain>
	<AF0367BA48C55940A43CCF08DF35553C012AA472@az33exm24.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 8 May 2007 07:29:20 -0700
"Loeliger Jon-LOELIGER" <jdl@freescale.com> wrote:

> 
> > > -       interrupt-controller@f8200000 {
> > > -               linux,phandle = <f8200000>;
> > > +		pci_pic:interrupt-controller@f8200000 {
> > 
> > I'd like to establish a convention of putting a space after the : and
> > using capitals for labels unless there's a strong reason not to in a
> > particular case.  It makes them easier to visually distinguish next to
> > the node name.
> 
> Colon-space is easy and I'll buy it.
> I'm not big on uppercase shouting, though.
> 
> Perhaps something more like case or goto labels:?
> 
>     pci_pic:
>         interrupt-contoller@f8200000 {
> 
> if needed?
> 
I used middle solution 
	Pci_pic: interrupt-contoller@f8200000 {
so first letter of the label should be uppercase.
It makes them easily distinguishable and at the same time, not "shouting" manner.


-- 
Sincerely, 
Vitaly
