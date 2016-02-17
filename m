Return-Path: <martin.petersen@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2714F1A03E6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 10:31:03 +1100 (AEDT)
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 brking@linux.vnet.ibm.com, nfont@linux.vnet.ibm.com
Subject: Re: [PATCH] ibmvfc: byteswap scsi_id, wwpn,
 and node_name prior to logging
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1455229475-3984-1-git-send-email-tyreld@linux.vnet.ibm.com>
Date: Wed, 17 Feb 2016 18:30:51 -0500
In-Reply-To: <1455229475-3984-1-git-send-email-tyreld@linux.vnet.ibm.com>
 (Tyrel Datwyler's message of "Thu, 11 Feb 2016 16:24:35 -0600")
Message-ID: <yq1d1ruud78.fsf@sermon.lab.mkp.net>
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

Tyrel> When logging async events the scsi_id, wwpn, and node_name values
Tyrel> are used directly from the CRQ struct which are of type
Tyrel> __be64. This can be confusing to someone looking through the log
Tyrel> on a LE system.  Instead byteswap these values to host endian
Tyrel> prior to logging.

Applied to 4.6/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
