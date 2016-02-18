Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6D1AD1A04EA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 01:37:21 +1100 (AEDT)
Message-ID: <1455806240.5284.19.camel@ellerman.id.au>
Subject: Re: [RFC 4/4] powerpc/mm: Rename global tracker for virtual to
 physical mapping
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com
Date: Fri, 19 Feb 2016 01:37:20 +1100
In-Reply-To: <1455711179-20357-4-git-send-email-khandual@linux.vnet.ibm.com>
References: <1455711179-20357-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1455711179-20357-4-git-send-email-khandual@linux.vnet.ibm.com>
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

On Wed, 2016-02-17 at 17:42 +0530, Anshuman Khandual wrote:

> This renames the global list which tracks all the virtual to physical
> mapping and also the global list which tracks all the available unused
> vmemmap_hw_map node structures.

But why? Why are the new names *so* much better that we would want to go
through all this churn?

> It also attempts to explain the purpose
> of these global linked lists and points out a possible race condition.

I'm happy to take the comments.

cheers
