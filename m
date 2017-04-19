Return-Path: <martin.petersen@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w74jh3ycwzDq8V
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 11:51:36 +1000 (AEST)
To: NeilBrown <neilb@suse.com>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: ibmvfc: don't check for failure from mempool_alloc()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <878tn9xb2m.fsf@notabene.neil.brown.name>
Date: Tue, 18 Apr 2017 21:51:28 -0400
In-Reply-To: <878tn9xb2m.fsf@notabene.neil.brown.name> (NeilBrown's message of
 "Mon, 10 Apr 2017 12:15:13 +1000")
Message-ID: <yq1h91ltba7.fsf@oracle.com>
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

NeilBrown <neilb@suse.com> writes:

> mempool_alloc() cannot fail when passed GFP_NOIO or any other gfp
> setting that is permitted to sleep.  So remove this pointless code.

Applied to 4.12/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
