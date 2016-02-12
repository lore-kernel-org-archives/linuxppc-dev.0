Return-Path: <manoj@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 524C61A002B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Feb 2016 01:29:41 +1100 (AEDT)
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <manoj@linux.vnet.ibm.com>;
 Fri, 12 Feb 2016 07:29:38 -0700
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 9F40019D8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 07:17:34 -0700 (MST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1CETZAM33751270
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 14:29:35 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1CETZtd029567
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 09:29:35 -0500
Reply-To: manoj@linux.vnet.ibm.com
Subject: Re: [PATCH v2 1/7] ibmvscsi: Correct values for several
 viosrp_crq_format enums
References: <1455154348-3226-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1455154348-3226-2-git-send-email-tyreld@linux.vnet.ibm.com>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 james.bottomley@hansenpartnership.com
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 nfont@linux.vnet.ibm.com, brking@linux.vnet.ibm.com, jthumshirn@suse.de
From: Manoj Kumar <manoj@linux.vnet.ibm.com>
Message-ID: <56BDEC53.3010400@linux.vnet.ibm.com>
Date: Fri, 12 Feb 2016 08:29:39 -0600
MIME-Version: 1.0
In-Reply-To: <1455154348-3226-2-git-send-email-tyreld@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Reviewed-by: Manoj Kumar <manoj@linux.vnet.ibm.com>

---
Manoj Kumar

On 2/10/2016 7:32 PM, Tyrel Datwyler wrote:
> The enum values for VIOSRP_LINUX_FORMAT and VIOSRP_INLINE_FORMAT are
> off by one. They are currently defined as 0x06 and 0x07 respetively.
> These values are defined in PAPR correctly as 0x05 and 0x06. This
> inconsistency has gone unnoticed as neither enum is currently used.
> The possible future support of PING messages between the VIOS and
> client adapter relies on VIOSRP_INLINE_FORMAT crq messages.
> Corrected these enum values to match PAPR definitions.
>
> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>   drivers/scsi/ibmvscsi/viosrp.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/ibmvscsi/viosrp.h b/drivers/scsi/ibmvscsi/viosrp.h
> index 1162430..d1044e9 100644
> --- a/drivers/scsi/ibmvscsi/viosrp.h
> +++ b/drivers/scsi/ibmvscsi/viosrp.h
> @@ -56,8 +56,8 @@ enum viosrp_crq_formats {
>   	VIOSRP_MAD_FORMAT = 0x02,
>   	VIOSRP_OS400_FORMAT = 0x03,
>   	VIOSRP_AIX_FORMAT = 0x04,
> -	VIOSRP_LINUX_FORMAT = 0x06,
> -	VIOSRP_INLINE_FORMAT = 0x07
> +	VIOSRP_LINUX_FORMAT = 0x05,
> +	VIOSRP_INLINE_FORMAT = 0x06
>   };
>
>   enum viosrp_crq_status {
>
