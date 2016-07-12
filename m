Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rptsg4QN2zDqDy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 06:31:35 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6CKTgGr083757
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 16:31:33 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24507b90mx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 16:31:32 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Tue, 12 Jul 2016 14:31:30 -0600
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH] cxl: remove dead Kconfig options
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <1467616334-20977-1-git-send-email-andrew.donnellan@au1.ibm.com>
Date: Tue, 12 Jul 2016 15:31:24 -0500
Cc: linuxppc-dev@lists.ozlabs.org, clombard@linux.vnet.ibm.com,
 linux-scsi@vger.kernel.org, fbarrat@linux.vnet.ibm.com,
 manoj@linux.vnet.ibm.com, imunsie@au1.ibm.com
References: <1467616334-20977-1-git-send-email-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-Id: <0E3E1855-3038-4414-A0A4-EABC431AEEA4@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Jul 4, 2016, at 2:12 AM, Andrew Donnellan =
<andrew.donnellan@au1.ibm.com> wrote:
>=20
> Remove the CXL_KERNEL_API and CXL_EEH Kconfig options, as they were =
only
> needed to coordinate the merging of the cxlflash driver. Also remove =
the
> stub implementation of cxl_perst_reloads_same_image() in cxlflash =
which is
> only used if CXL_EEH isn't defined (i.e. never).
>=20
> Suggested-by: Ian Munsie <imunsie@au1.ibm.com>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
