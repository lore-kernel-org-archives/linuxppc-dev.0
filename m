Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429sRx6dP1zF3Rc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 18:35:57 +1000 (AEST)
Message-ID: <d51126f75116534ec6ba6caee907b9db82363cc7.camel@kernel.crashing.org>
Subject: Re: [PATCH] MAINTAINERS: Add PPC contacts for PCI core error handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, Russell
 Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-kernel@vger.kernel.org, Oliver OHalloran <oliveroh@au1.ibm.com>
Date: Thu, 13 Sep 2018 10:35:38 +0200
In-Reply-To: <20180912165846.GH118330@bhelgaas-glaptop.roam.corp.google.com>
References: <153677132617.23091.12307288405707171077.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180912165846.GH118330@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-09-12 at 11:58 -0500, Bjorn Helgaas wrote:
> > Add the generic PCI core error recovery files to the powerpc EEH
> > MAINTAINERS entry so the powerpc folks will be copied on changes to the
> > generic PCI error handling strategy.
> 
> I really want to make sure the powerpc folks are plugged into any PCI core
> error handling discussions.  Please let me know if there's a better way
> than this patch, or if there are other people who should be added.

Sounds good. Oliver, you want to be looped in as well ?

Cheers,
Ben.
