Return-Path: <martin.petersen@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tZTsb44ZlzDw6K
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Dec 2016 09:04:02 +1100 (AEDT)
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 brking@linux.vnet.ibm.com, nfont@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] ibmvscsi: add vscsi hosts to global list_head
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1481148276-5083-1-git-send-email-tyreld@linux.vnet.ibm.com>
Date: Thu, 08 Dec 2016 17:03:41 -0500
In-Reply-To: <1481148276-5083-1-git-send-email-tyreld@linux.vnet.ibm.com>
 (Tyrel Datwyler's message of "Wed, 7 Dec 2016 16:04:35 -0600")
Message-ID: <yq1k2baoz7m.fsf@sermon.lab.mkp.net>
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

Tyrel> Add each vscsi host adatper to a new global list_head named
Tyrel> ibmvscsi_head. There is no functional change. This is meant
Tyrel> primarily as a convience for locating adatpers from within the
Tyrel> debugger or crash utility.

Applied 1+2 to 4.10/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
