Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wpJ4g5C2JzDqL8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 19:25:07 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Yongji Xie <elohimes@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Yongji Xie <xyjxie@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel 2/3] pci-ioda: Set PCI_BUS_FLAGS_MSI_REMAP for IODA
 host bridge
In-Reply-To: <20170615054845.8428-3-aik@ozlabs.ru>
References: <20170615054845.8428-1-aik@ozlabs.ru>
 <20170615054845.8428-3-aik@ozlabs.ru>
Date: Thu, 15 Jun 2017 19:25:06 +1000
Message-ID: <877f0dppql.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> From: Yongji Xie <elohimes@gmail.com>
>
> Any IODA host bridge have the capability of IRQ remapping.
> So we set PCI_BUS_FLAGS_MSI_REMAP when this kind of host birdge
> is detected.

Where's the code that actually enforces this property?

It would be good to have a comment in pnv_pci_ioda_root_bridge_prepare()
(probably), pointing to that code, so that we can remember the
relationship between the two.

cheers
