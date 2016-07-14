Return-Path: <martin.petersen@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqf9H4bg1zDqFR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 12:02:43 +1000 (AEST)
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, imunsie@au1.ibm.com,
 mrochs@linux.vnet.ibm.com, linux-scsi@vger.kernel.org,
 manoj@linux.vnet.ibm.com, clombard@linux.vnet.ibm.com,
 fbarrat@linux.vnet.ibm.com
Subject: Re: [PATCH] cxl: remove dead Kconfig options
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1467616334-20977-1-git-send-email-andrew.donnellan@au1.ibm.com>
Date: Wed, 13 Jul 2016 22:02:31 -0400
In-Reply-To: <1467616334-20977-1-git-send-email-andrew.donnellan@au1.ibm.com>
 (Andrew Donnellan's message of "Mon, 4 Jul 2016 17:12:14 +1000")
Message-ID: <yq1k2gpm0y0.fsf@sermon.lab.mkp.net>
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

>>>>> "Andrew" == Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:

Andrew> Remove the CXL_KERNEL_API and CXL_EEH Kconfig options, as they
Andrew> were only needed to coordinate the merging of the cxlflash
Andrew> driver. Also remove the stub implementation of
Andrew> cxl_perst_reloads_same_image() in cxlflash which is only used if
Andrew> CXL_EEH isn't defined (i.e. never).

This patch straddles a few subsystems. Did you intend for me to queue it
through SCSI?

-- 
Martin K. Petersen	Oracle Linux Engineering
