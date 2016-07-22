Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rwvwY0mNbzDrL3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jul 2016 01:39:56 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6MFdBgs002096
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 11:39:55 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24bhv0a9ss-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 11:39:54 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Fri, 22 Jul 2016 11:39:53 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 25E2438C8039
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 11:39:46 -0400 (EDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH] cxl: fix sparse warnings
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <1469178096-8510-1-git-send-email-andrew.donnellan@au1.ibm.com>
Date: Fri, 22 Jul 2016 10:39:42 -0500
Cc: linuxppc-dev@lists.ozlabs.org, felix@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com, imunsie@au1.ibm.com,
 fbarrat@linux.vnet.ibm.com, clombard@linux.vnet.ibm.com
References: <1469178096-8510-1-git-send-email-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-Id: <D0635BFB-E1A6-49D8-BE8B-2BC904AC1579@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Jul 22, 2016, at 4:01 AM, Andrew Donnellan =
<andrew.donnellan@au1.ibm.com> wrote:
>=20
> Make native_irq_wait() static and use NULL rather than 0 to initialise
> phb->cfg_data in cxl_pci_vphb_add() to remove sparse warnings.
>=20
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Reviewed-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
