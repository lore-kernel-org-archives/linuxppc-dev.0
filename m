Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41yBkN31TlzDqwb
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Aug 2018 18:52:59 +1000 (AEST)
Date: Sat, 25 Aug 2018 10:55:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Anshuman Khandual <anshuman.linux@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christoph Hellwig <hch@lst.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Mike Anderson <andmike@linux.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Ram Pai <linuxram@us.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 11/11] powerpc/svm: Increase SWIOTLB buffer size
Message-ID: <20180825085500.GA5991@lst.de>
References: <20180824025933.24319-1-bauerman@linux.ibm.com>
 <20180824025933.24319-12-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180824025933.24319-12-bauerman@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +config SWIOTLB_DEFAULT_SIZE
> +       int "Size of Software I/O TLB buffer (in MiB)"
> +       default "1024"
> +       depends on PPC_SVM
> +

This belongs into kernel/dma/Kconfig.  That being said I really
don't see why this should be a user visible Kconfig.
