Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6WWC68YqzDqgD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 04:55:51 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6BIsFGF020040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 14:55:48 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bn0mxh5v5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 14:55:48 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Tue, 11 Jul 2017 12:55:47 -0600
Subject: Re: [PATCH 3/3] PCI: hotplug: constify attribute_group structures.
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, bhelgaas@google.com,
 paulus@samba.org, mpe@ellerman.id.au, benh@kernel.crashing.org
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <1499765324-617-1-git-send-email-arvind.yadav.cs@gmail.com>
 <1499765324-617-2-git-send-email-arvind.yadav.cs@gmail.com>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Tue, 11 Jul 2017 11:55:40 -0700
MIME-Version: 1.0
In-Reply-To: <1499765324-617-2-git-send-email-arvind.yadav.cs@gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <97d8f7b5-7939-6abb-4883-4582a16f374e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/11/2017 02:28 AM, Arvind Yadav wrote:
> attribute_groups are not supposed to change at runtime. All functions
> working with attribute_groups provided by <linux/sysfs.h> work
> with const attribute_group. So mark the non-const structs as const.
> 
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>     418	    160	      8	    586	    24a	drivers/pci/hotplug/rpadlpar_sysfs.o
> 
> File size After adding 'const':
>    text	   data	    bss	    dec	    hex	filename
>     482	     96	      8	    586	    232	drivers/pci/hotplug/rpadlpar_sysfs.o
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Reviewed-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
