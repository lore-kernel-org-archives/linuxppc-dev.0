Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4981B1A028E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Feb 2016 16:51:23 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 1 Feb 2016 15:51:22 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C5D133578054
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Feb 2016 16:51:19 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u115pDRu36175990
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Feb 2016 16:51:21 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u115okPn030865
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Feb 2016 16:50:46 +1100
Message-ID: <56AEF223.2000802@linux.vnet.ibm.com>
Date: Mon, 01 Feb 2016 11:20:27 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>, paulus@samba.org,
 mpe@ellerman.id.au, benh@kernel.crashing.org
CC: aik@ozlabs.ru, lvivier@redhat.com, thuth@redhat.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFCv2 1/9] memblock: Don't mark memblock_phys_mem_size() as
 __init
References: <1454045043-25545-1-git-send-email-david@gibson.dropbear.id.au>
 <1454045043-25545-2-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1454045043-25545-2-git-send-email-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/29/2016 10:53 AM, David Gibson wrote:
> At the moment memblock_phys_mem_size() is marked as __init, and so is
> discarded after boot.  This is different from most of the memblock
> functions which are marked __init_memblock, and are only discarded after
> boot if memory hotplug is not configured.
> 
> To allow for upcoming code which will need memblock_phys_mem_size() in the
> hotplug path, change it from __init to __init_memblock.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
