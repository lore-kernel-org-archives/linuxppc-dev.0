Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A3B541A066A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 01:23:58 +1100 (AEDT)
Message-ID: <1455805437.5284.14.camel@ellerman.id.au>
Subject: Re: [RFC 3/4] powerpc/mm: Rename the vmemmap_backing struct and its
 elements
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Anshuman Khandual
 <khandual@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Fri, 19 Feb 2016 01:23:57 +1100
In-Reply-To: <87bn7fz8vo.fsf@linux.vnet.ibm.com>
References: <1455711179-20357-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1455711179-20357-3-git-send-email-khandual@linux.vnet.ibm.com>
 <87bn7fz8vo.fsf@linux.vnet.ibm.com>
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

On Wed, 2016-02-17 at 20:22 +0530, Aneesh Kumar K.V wrote:

> Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:
>

> > The structure to track single virtual to physical mapping has
> > been renamed from vmemmap_backing to vmemmap_hw_map which sounds
> > more appropriate. This forms a single entry of the global linked
> > list tracking all of the vmemmap physical mapping. The changes
> > are as follows.
> >
> > 	vmemmap_backing.list -> vmemmap_hw_map.link
> > 	vmemmap_backing.phys -> vmemmap_hw_map.paddr
> > 	vmemmap_backing.virt_addr -> vmemmap_hw_map.vaddr
>
> I am not sure this helps. If we are going to take these renames, can you
> wait till th book3s p9 preparation patches [1] hit upstream ?

I don't see why the new names are any better, and it's a lot of churn for
minimal if any benefit. So I'm not going to take this one.

cheers
