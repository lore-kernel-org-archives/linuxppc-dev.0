Return-Path: <martin.petersen@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AF77A1A009E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Feb 2016 03:55:13 +1100 (AEDT)
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, nfont@linux.vnet.ibm.com,
 brking@linux.vnet.ibm.com, jthumshirn@suse.de, manoj@linux.vnet.ibm.com
Subject: Re: [PATCH v2 0/7] ibmvscsi code cleanup
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1455154348-3226-1-git-send-email-tyreld@linux.vnet.ibm.com>
Date: Fri, 12 Feb 2016 11:55:02 -0500
In-Reply-To: <1455154348-3226-1-git-send-email-tyreld@linux.vnet.ibm.com>
 (Tyrel Datwyler's message of "Wed, 10 Feb 2016 19:32:21 -0600")
Message-ID: <yq1lh6p27ix.fsf@sermon.lab.mkp.net>
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

Tyrel> Fixed up a couple spots that were out of line with the PAPR in
Tyrel> regards to its defined VSCSI protocol. Did away with some magic
Tyrel> numbers directly in the code. Fixed a minor endian issue.

Applied to 4.6/scsi-queue.

(And added the missing review from Johannes for patch 3 as pointed out
by James).

-- 
Martin K. Petersen	Oracle Linux Engineering
