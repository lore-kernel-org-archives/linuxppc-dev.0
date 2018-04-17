Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40QhqJ0mLQzF1yM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2018 09:51:39 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3HNnRiJ057492
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 19:51:36 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hds1yc0up-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 19:51:36 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 18 Apr 2018 00:51:34 +0100
Subject: Re: [PATCH] misc: cxl: Change return type to vm_fault_t
To: Souptick Joarder <jrdr.linux@gmail.com>, fbarrat@linux.vnet.ibm.com,
 arnd@arndb.de, gregkh@linuxfoundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 willy@infradead.org
References: <20180417145354.GA31451@jordon-HP-15-Notebook-PC>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 18 Apr 2018 09:51:27 +1000
MIME-Version: 1.0
In-Reply-To: <20180417145354.GA31451@jordon-HP-15-Notebook-PC>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <384a35d1-30dd-55d1-4a19-d7c9dc99bdfb@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 18/04/18 00:53, Souptick Joarder wrote:
> Use new return type vm_fault_t for fault handler. For
> now, this is just documenting that the function returns
> a VM_FAULT value rather than an errno. Once all instances
> are converted, vm_fault_t will become a distinct type.
> 
> Reference id -> 1c8f422059ae ("mm: change return type to
> vm_fault_t")
> 
> previously cxl_mmap_fault returns VM_FAULT_NOPAGE as
> default value irrespective of vm_insert_pfn() return
> value. This bug is fixed with new vmf_insert_pfn()
> which will return VM_FAULT_ type based on err.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

This looks good to me

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
