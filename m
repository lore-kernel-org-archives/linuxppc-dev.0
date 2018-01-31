Return-Path: <martin.petersen@oracle.com>
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zWRhf0CQYzDr3J
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jan 2018 13:17:05 +1100 (AEDT)
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 brking@linux.vnet.ibm.com, nfont@linux.vnet.ibm.com, hare@suse.de,
 stable@vger.kernel.org
Subject: Re: [PATCH] ibmvfc: fix misdefined reserved field in
 ibmvfc_fcp_rsp_info
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1516759892-31245-1-git-send-email-tyreld@linux.vnet.ibm.com>
Date: Tue, 30 Jan 2018 21:16:55 -0500
In-Reply-To: <1516759892-31245-1-git-send-email-tyreld@linux.vnet.ibm.com>
 (Tyrel Datwyler's message of "Tue, 23 Jan 2018 20:11:32 -0600")
Message-ID: <yq11si6hiw8.fsf@oracle.com>
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


Tyrel,

> The fcp_rsp_info structure as defined in the FC spec has an initial 3 bytes
> reserved field. The ibmvfc driver mistakenly defined this field as 4 bytes
> resulting in the rsp_code field being defined in what should be the start of
> the second reserved field and thus always being reported as zero by the
> driver.

Applied to 4.16/scsi-fixes, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
