Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B35D91A0337
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 01:53:09 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 17 Feb 2016 07:53:07 -0700
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 64A261FF002D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 07:41:14 -0700 (MST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1HEr4jJ33751202
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:53:04 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1HEr3aU028601
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 09:53:03 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC 3/4] powerpc/mm: Rename the vmemmap_backing struct and its
 elements
In-Reply-To: <1455711179-20357-3-git-send-email-khandual@linux.vnet.ibm.com>
References: <1455711179-20357-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1455711179-20357-3-git-send-email-khandual@linux.vnet.ibm.com>
Date: Wed, 17 Feb 2016 20:22:59 +0530
Message-ID: <87bn7fz8vo.fsf@linux.vnet.ibm.com>
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

Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:

> The structure to track single virtual to physical mapping has
> been renamed from vmemmap_backing to vmemmap_hw_map which sounds
> more appropriate. This forms a single entry of the global linked
> list tracking all of the vmemmap physical mapping. The changes
> are as follows.
>
> 	vmemmap_backing.list -> vmemmap_hw_map.link
> 	vmemmap_backing.phys -> vmemmap_hw_map.paddr
> 	vmemmap_backing.virt_addr -> vmemmap_hw_map.vaddr
>

I am not sure this helps. If we are going to take these renames, can you
wait till th book3s p9 preparation patches [1] hit upstream ? 

[1] http://mid.gmane.org/1454923241-6681-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com
-aneesh
