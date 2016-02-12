Return-Path: <martin.petersen@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 176E31A002B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Feb 2016 03:58:08 +1100 (AEDT)
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, nfont@linux.vnet.ibm.com,
 brking@linux.vnet.ibm.com, jthumshirn@suse.de, manoj@linux.vnet.ibm.com
Subject: Re: [PATCH v2 3/7] ibmvscsi: Replace magic values in
 set_adpater_info() with defines
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1455154348-3226-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1455154348-3226-4-git-send-email-tyreld@linux.vnet.ibm.com>
 <1455295395.2396.22.camel@HansenPartnership.com>
 <56BE0D7D.3050703@linux.vnet.ibm.com>
 <1455295989.2396.23.camel@HansenPartnership.com>
Date: Fri, 12 Feb 2016 11:57:59 -0500
In-Reply-To: <1455295989.2396.23.camel@HansenPartnership.com> (James
 Bottomley's message of "Fri, 12 Feb 2016 08:53:09 -0800")
Message-ID: <yq1h9hd27e0.fsf@sermon.lab.mkp.net>
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

>>>>> "James" == James Bottomley <James.Bottomley@HansenPartnership.com> writes:

James> OK we need a re-review then ...

I'll hold off pushing for now.

-- 
Martin K. Petersen	Oracle Linux Engineering
