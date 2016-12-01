Return-Path: <martin.petersen@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTf6q3h2TzDvr1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 11:58:43 +1100 (AEDT)
To: Brian King <brking@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-scsi@vger.kernel.org,
 "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linuxppc dev list <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] scsi/ipr: Fix runaway IRQs when falling back from MSI to
 LSI
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1479947042.10230.88.camel@kernel.crashing.org>
 <683a1049-2ff3-2777-b908-062212008ae4@linux.vnet.ibm.com>
Date: Wed, 30 Nov 2016 19:58:33 -0500
In-Reply-To: <683a1049-2ff3-2777-b908-062212008ae4@linux.vnet.ibm.com> (Brian
 King's message of "Wed, 30 Nov 2016 15:28:55 -0600")
Message-ID: <yq1lgw0h3d2.fsf@sermon.lab.mkp.net>
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

>>>>> "Brian" == Brian King <brking@linux.vnet.ibm.com> writes:

Brian> Looks good. Thanks! Here is an updated version that should apply
Brian> cleanly on top of scsi-next.

Applied to 4.10/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
