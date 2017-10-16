Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yG0Lr3lDhzDrGD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 00:59:48 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9GDxEDr083406
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 09:59:45 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dmvm74vxn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 09:59:45 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Mon, 16 Oct 2017 14:59:42 +0100
Subject: Re: [PATCH v2] cxl: Dump PSL_FIR register on PSL9 error irq
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
References: <20171011061441.16795-1-vaibhav@linux.vnet.ibm.com>
From: christophe lombard <clombard@linux.vnet.ibm.com>
Date: Mon, 16 Oct 2017 15:59:36 +0200
MIME-Version: 1.0
In-Reply-To: <20171011061441.16795-1-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <7ffecace-7057-0fd0-f0f5-fb873557e428@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 11/10/2017 à 08:14, Vaibhav Jain a écrit :

> For PSL9 currently we aren't dumping the PSL FIR register when a
> PSL error interrupt is triggered. Contents of this register are useful
> in debugging AFU issues.
>
> This patch fixes issue by adding a new service_layer_ops callback
> cxl_native_err_irq_dump_regs_psl9() to dump the PSL_FIR registers on a
> PSL error interrupt thereby bringing the behavior in line with PSL on
> POWER-8. Also the existing service_layer_ops callback
> for PSL8 has been renamed to cxl_native_err_irq_dump_regs_psl8().
>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---
> Changelog:
> [v2] -> As created a different function to dump the FIR register for PSL9 (Fred)
> ---
>
Thanks

Acked-by:  Christophe Lombard<clombard@linux.vnet.ibm.com>
