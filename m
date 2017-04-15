Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w57sg4mYPzDq8V
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Apr 2017 08:06:47 +1000 (AEST)
Message-ID: <1492293974.25766.30.camel@kernel.crashing.org>
Subject: Re: [PATCH v10 3/4] powerpc/powernv: Override
 pcibios_default_alignment() to force PCI devices to be page aligned
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Yongji Xie <elohimes@gmail.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Ellerman
 <mpe@ellerman.id.au>, "paulus@samba.org" <paulus@samba.org>, Li Zhong
 <zhong@linux.vnet.ibm.com>
Date: Sun, 16 Apr 2017 08:06:14 +1000
In-Reply-To: <CAErSpo5Orx8c453Fn6-PX-7woseSkZFcYO1Yu+1L+B-h6w0T+A@mail.gmail.com>
References: <1491825494-19331-1-git-send-email-elohimes@gmail.com>
 <1491825494-19331-4-git-send-email-elohimes@gmail.com>
 <20170414155849.GB5864@bhelgaas-glaptop.roam.corp.google.com>
 <1492206774.25766.14.camel@kernel.crashing.org>
 <CAErSpo5Orx8c453Fn6-PX-7woseSkZFcYO1Yu+1L+B-h6w0T+A@mail.gmail.com>
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

On Sat, 2017-04-15 at 11:36 -0500, Bjorn Helgaas wrote:
> > I agree in principle. I'm surprised that PowerPC is the only one
> > interested here though, what about other platforms who want to use
> > KVM and PCI pass-through and use Linux to assign BARs ?
> 
> If I understand correctly, the problem is with BARs smaller than a
> page, and this happens more on PowerPC because larger page sizes are
> more common there.

Yes, it happens "more". That doesn't mean it doesn't happen at all on
others :-) Anyway, I'm not objecting, just surprised.

Cheers,
Ben.
