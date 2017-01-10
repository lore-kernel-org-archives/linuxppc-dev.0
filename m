Return-Path: <martin.petersen@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tyKc42rQszDqHy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 16:01:07 +1100 (AEDT)
To: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Cc: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/4] cxlflash: Enhancements, cleanup and fixes
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1483711379-18188-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Date: Tue, 10 Jan 2017 00:00:55 -0500
In-Reply-To: <1483711379-18188-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 (Uma Krishnan's message of "Fri, 6 Jan 2017 08:02:59 -0600")
Message-ID: <yq1ziizbjaw.fsf@oracle.com>
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

>>>>> "Uma" == Uma Krishnan <ukrishn@linux.vnet.ibm.com> writes:

Uma,

Uma> This patch series includes an enhancement to support a new command
Uma> queuing model and also cleans up prints throughout the driver. The
Uma> last patch in the series fixes a racing issue.

Uma> The series is based upon v4.10-rc2, intended for 4.11 and is
Uma> bisectable.

Uma> Matthew R. Ochs (3):
Uma>   cxlflash: Refactor context reset to share reset logic cxlflash:
Uma>   Support SQ Command Mode cxlflash: Cleanup prints

The first three patches in the series were submitted by you but do not
carry your Signed-off-by:...

-- 
Martin K. Petersen	Oracle Linux Engineering
