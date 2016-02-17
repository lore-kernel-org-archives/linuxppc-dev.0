Return-Path: <martin.petersen@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 19F161A029A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:03:37 +1100 (AEDT)
To: jthumshirn@suse.de
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
 martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 nfont@linux.vnet.ibm.com, brking@linux.vnet.ibm.com,
 manoj@linux.vnet.ibm.com, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 3/7] ibmvscsi: Replace magic values in
 set_adpater_info() with defines
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1455154348-3226-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1455154348-3226-4-git-send-email-tyreld@linux.vnet.ibm.com>
 <1455295395.2396.22.camel@HansenPartnership.com>
 <56BE0D7D.3050703@linux.vnet.ibm.com>
Date: Tue, 16 Feb 2016 22:03:24 -0500
In-Reply-To: <56BE0D7D.3050703@linux.vnet.ibm.com> (Tyrel Datwyler's message
 of "Fri, 12 Feb 2016 08:51:09 -0800")
Message-ID: <yq1k2m4xclf.fsf@sermon.lab.mkp.net>
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

>> Is there some reason you didn't carry the review tag over from this:
>> 
>> http://mid.gmane.org/20160204084459.GW27969@c203.arch.suse.de
>> 
>> ?
>> 
>> James

Tyrel> The patch is slightly changed from v1. A define for AIX os type
Tyrel> was added as mentioned in the cover letter v2 changes, and I
Tyrel> moved the defines to the mad_adapter_info_data structure around
Tyrel> the fields they apply.

Johannes: Mind checking this out?

https://patchwork.kernel.org/patch/8276101/

-- 
Martin K. Petersen	Oracle Linux Engineering
