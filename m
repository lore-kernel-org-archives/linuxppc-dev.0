Return-Path: <shawnxjin@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.181])
	by ozlabs.org (Postfix) with ESMTP id D752667B71
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jun 2006 10:45:24 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id m51so553553pye
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 17:45:23 -0700 (PDT)
Message-ID: <c3d0340b0606151745w5bab060dq7ae6b7d74c59d074@mail.gmail.com>
Date: Thu, 15 Jun 2006 17:45:22 -0700
From: "Shawn Jin" <shawnxjin@gmail.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: MSI support on Linux PCI implementation for Ocotea
In-Reply-To: <1150413771.7725.20.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <c3d0340b0606151414q6d218554j255fa74a68a5c9af@mail.gmail.com>
	<1150413771.7725.20.camel@localhost.localdomain>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, ppcembed <linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Hi ! What is Ocotea ! :)

Did I spell it wrong?? I don't believe Ben doesn't know Ocotea.
Hmmm...Ocotea again? Let me check if I really spelled it wrong. Hey,
it's really Ocotea. ;)

Of course, there is no such MSI support specific for Ocotea.

> > 1. Obviously MSI is supported in Linux 2.6.x, maybe even in 2.4.x. But
> > MSI implementation seems to support only IOxAPIC on x86 or IA64
> > architectures, though the implemenation is in generic drivers/pci
> > tree.
>
> Exact. And it's also a pile of crap.

;) I'm not in a position where I can either agree or disagree with
you. :D But may I ask if ppc platform can make use of this crap in our
PCI express testing? That is, are the functionalities of this crap
working?

> pci host bridges are initialized early, generally in setup_arch() and
> the PCI bus is probed later. You can see the code in
> arch/powerpc/kernel/pci_{32,64}.c
>
> Now, regarding MSI, as you have noticed, the situation isn't great. I'm
> currently in the middle of reworking our interrupt management (and
> interrupt numbers allocation layer) and Michael Ellermann is looking at
> the MSI issue in parallel.
>
> We don't have a solution yet but are working on it.

It's good to know the development status. What's the relationship
between generic pci driver layer in drivers/pci and architecture
specific implementation? One thing I notice is that architectures
provide pcibios_init() and do resource allocation while the generic
driver provides PCI generic functions such as pci_scan_device().

Thanks,
-Shawn.
