Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTV4h5MSTzDr5F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 01:57:08 +1000 (AEST)
Date: Fri, 11 Aug 2017 10:56:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jason Cooper <jason@lakedaemon.net>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH] PCI: Convert to using %pOF instead of full_name
Message-ID: <20170811155658.GA17039@bhelgaas-glaptop.roam.corp.google.com>
References: <20170718214339.7774-41-robh@kernel.org>
 <20170802223928.GQ20308@bhelgaas-glaptop.roam.corp.google.com>
 <CAL_JsqLznQdnWw+A2T8V8CTktYaPDF_800jGHAVa=G-Yhxyn+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAL_JsqLznQdnWw+A2T8V8CTktYaPDF_800jGHAVa=G-Yhxyn+Q@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[+cc Tyrel]

On Wed, Aug 09, 2017 at 05:04:43PM -0500, Rob Herring wrote:
> On Wed, Aug 2, 2017 at 5:39 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Jul 18, 2017 at 04:43:21PM -0500, Rob Herring wrote:
> >> Now that we have a custom printf format specifier, convert users of
> >> full_name to use %pOF instead. This is preparation to remove storing
> >> of the full path string for each node.
> >>
> >> Signed-off-by: Rob Herring <robh@kernel.org>
> >> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> >> Cc: Jason Cooper <jason@lakedaemon.net>
> >> Cc: Bjorn Helgaas <bhelgaas@google.com>
> >> Cc: Thierry Reding <thierry.reding@gmail.com>
> >> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> >> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >> Cc: Paul Mackerras <paulus@samba.org>
> >> Cc: Michael Ellerman <mpe@ellerman.id.au>
> >> Cc: linux-pci@vger.kernel.org
> >> Cc: linux-arm-kernel@lists.infradead.org
> >> Cc: linux-tegra@vger.kernel.org
> >> Cc: linuxppc-dev@lists.ozlabs.org
> >
> > Applied to pci/misc for v4.14, thanks!
> 
> This hasn't shown up in -next.

Thanks, it should be in next-20170811.

I updated it to add Tyrel's reviewed-by, but that's not in -next yet.
