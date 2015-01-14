Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 98A6F1A0C84
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jan 2015 15:31:04 +1100 (AEDT)
Message-ID: <1421209863.10748.11.camel@ellerman.id.au>
Subject: Re: [PATCH v3 2/3] pstore: Add pstore type id for firmware partition
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Wed, 14 Jan 2015 15:31:03 +1100
In-Reply-To: <20141224115842.25731.94235.stgit@localhost.localdomain>
References: <20141224115729.25731.20371.stgit@localhost.localdomain>
 <20141224115842.25731.94235.stgit@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-12-24 at 17:28 +0530, Hari Bathini wrote:
> This patch adds a pstore type id to be used for opal specific
> nvram partitions.

This needs to be CC'ed to the pstore maintainers, and at the very least get an
ACK from them.

They also might ask why we need another powerpc specific pstore type, we
already have 3 of the 7 that exist.

cheers
