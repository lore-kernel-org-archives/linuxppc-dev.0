Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 14F461A006B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Feb 2016 03:51:19 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Fri, 12 Feb 2016 11:51:17 -0500
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id B7F4D6E803F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 11:38:06 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1CGpEuC30081232
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 16:51:14 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1CGpBnV008421
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 11:51:14 -0500
Subject: Re: [PATCH v2 3/7] ibmvscsi: Replace magic values in
 set_adpater_info() with defines
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
References: <1455154348-3226-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1455154348-3226-4-git-send-email-tyreld@linux.vnet.ibm.com>
 <1455295395.2396.22.camel@HansenPartnership.com>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 nfont@linux.vnet.ibm.com, brking@linux.vnet.ibm.com,
 jthumshirn@suse.de, manoj@linux.vnet.ibm.com
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Message-ID: <56BE0D7D.3050703@linux.vnet.ibm.com>
Date: Fri, 12 Feb 2016 08:51:09 -0800
MIME-Version: 1.0
In-Reply-To: <1455295395.2396.22.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/12/2016 08:43 AM, James Bottomley wrote:
> On Wed, 2016-02-10 at 19:32 -0600, Tyrel Datwyler wrote:
>> Add defines for mad version and mad os_type, and replace the magic
>> numbers in set_adapter_info() accordingly.
>>
>> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
>> ---
> 
> Is there some reason you didn't carry the review tag over from this:
> 
> http://mid.gmane.org/20160204084459.GW27969@c203.arch.suse.de
> 
> ?
> 
> James

The patch is slightly changed from v1. A define for AIX os type was
added as mentioned in the cover letter v2 changes, and I moved the
defines to the mad_adapter_info_data structure around the fields they apply.

-Tyrel

> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
