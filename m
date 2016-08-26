Return-Path: <martin.petersen@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sL60x0ljCzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 13:27:12 +1000 (AEST)
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 brking@linux.vnet.ibm.com, nfont@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, mpe@ellerman.id.au
Subject: Re: [PATCH 0/2] ibmvfc: FC-TAPE Support
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1470260213-19087-1-git-send-email-tyreld@linux.vnet.ibm.com>
Date: Thu, 25 Aug 2016 23:26:59 -0400
In-Reply-To: <1470260213-19087-1-git-send-email-tyreld@linux.vnet.ibm.com>
 (Tyrel Datwyler's message of "Wed, 3 Aug 2016 16:36:51 -0500")
Message-ID: <yq1mvk09pmk.fsf@sermon.lab.mkp.net>
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

>>>>> "Tyrel" == Tyrel Datwyler <tyreld@linux.vnet.ibm.com> writes:

Tyrel> This patchset introduces optional FC-TAPE/FC Class 3 Error
Tyrel> Recovery to the ibmvfc client driver.

Applied to 4.9/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
