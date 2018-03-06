Return-Path: <martin.petersen@oracle.com>
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwl3Q6kvFzF1Xk
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 05:02:03 +1100 (AEDT)
To: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Cc: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 00/38] cxlflash: OCXL transport support
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1519683513-16731-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Date: Tue, 06 Mar 2018 13:01:54 -0500
In-Reply-To: <1519683513-16731-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 (Uma Krishnan's message of "Mon, 26 Feb 2018 16:18:33 -0600")
Message-ID: <yq18tb5rskt.fsf@oracle.com>
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


> This patch series adds OCXL support to the cxlflash driver. With this
> support, new devices using the OCXL transport will be supported by the
> cxlflash driver along with the existing CXL devices. An effort is made
> to keep this transport specific function independent of the existing
> core driver that communicates with the AFU.

This one has been sitting for a week without any reviews. Andrew, when
will you have time to take a look?

Being a pretty big chunk of code, I would like to merge it sooner rather
than later. Or we can postpone until 4.18, of course.

-- 
Martin K. Petersen	Oracle Linux Engineering
