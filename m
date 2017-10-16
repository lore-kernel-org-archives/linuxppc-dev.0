Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yFym71Z8hzDrGD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 23:48:06 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9GChuBn099912
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 08:48:04 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dmuqd3sve-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 08:48:03 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Mon, 16 Oct 2017 13:48:02 +0100
Subject: Re: [PATCH] cxl: Rename register PSL9_FIR2 to PSL9_FIR_MASK
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
References: <20171009175627.4829-1-vaibhav@linux.vnet.ibm.com>
From: christophe lombard <clombard@linux.vnet.ibm.com>
Date: Mon, 16 Oct 2017 14:47:56 +0200
MIME-Version: 1.0
In-Reply-To: <20171009175627.4829-1-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <c2fe7647-cd9d-d298-69f0-4a10c2febe9d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 09/10/2017 à 19:56, Vaibhav Jain a écrit :

> PSL9 doesn't have a FIR2 register as was the case with PSL8. However
> currently the register definitions in 'cxl.h' have a definition for
> PSL9_FIR2 that actually points to PSL9_FIR_MASK register in the P1
> area at offset 0x308.
>
> So this patch renames the def PSL9_FIR2 to PSL9_FIR_MASK and updates
> the references in the code to point to the new identifier. It also
> removes the code to dump contents of FIR2 (FIR_MASK actually) in
> cxl_native_irq_dump_regs_psl9().
>
> Fixes: f24be42aab37("cxl: Add psl9 specific code")
> Reported-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
>
Thanks

Acked-by:  Christophe Lombard<clombard@linux.vnet.ibm.com>
