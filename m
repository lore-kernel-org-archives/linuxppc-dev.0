Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 221762C0500
 for <linuxppc-dev@ozlabs.org>; Mon, 24 Jun 2013 16:43:46 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Mon, 24 Jun 2013 12:08:43 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 65BF03940057
 for <linuxppc-dev@ozlabs.org>; Mon, 24 Jun 2013 12:13:41 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5O6hsxH27590740
 for <linuxppc-dev@ozlabs.org>; Mon, 24 Jun 2013 12:13:54 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5O6heRe030909
 for <linuxppc-dev@ozlabs.org>; Mon, 24 Jun 2013 16:43:41 +1000
Message-ID: <51C7EA9C.60505@linux.vnet.ibm.com>
Date: Mon, 24 Jun 2013 12:13:40 +0530
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc/pseries: Enable PSTORE in pseries_defconfig
References: <20130621083639.4039.27789.stgit@aruna-ThinkPad-T420>
 <7684.1372036896@ale.ozlabs.ibm.com>
In-Reply-To: <7684.1372036896@ale.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: mahesh@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Monday 24 June 2013 06:51 AM, Michael Neuling wrote:
>> Enable PSTORE in pseries_defconfig
> Please add a "why" to your changelogs eg. "Now we have pstore support for
> nvram on pseries, enable it in the default config"
>
> "Why" you are changing something is more important than "what", since
> you can always determine "what" is being changed, by looking at the diff.
> The "why" will be long forgotten.
>
>> Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/configs/pseries_defconfig |    1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
>> index c4dfbaf..9630a50 100644
>> --- a/arch/powerpc/configs/pseries_defconfig
>> +++ b/arch/powerpc/configs/pseries_defconfig
>> @@ -347,3 +347,4 @@ CONFIG_VIRTUALIZATION=y
>>   CONFIG_KVM_BOOK3S_64=m
>>   CONFIG_KVM_BOOK3S_64_HV=y
>>   CONFIG_VHOST_NET=m
>> +CONFIG_PSTORE=y
> This should really be added in the right location on the config, not
> just at the end.   ie.

Sorry, I overlooked this commentin my v2 patch. Will resend.

> @@ -296,6 +293,7 @@
>   CONFIG_SQUASHFS_XATTR=y
>   CONFIG_SQUASHFS_LZO=y
>   CONFIG_SQUASHFS_XZ=y
> +CONFIG_PSTORE=y
>   CONFIG_NFS_FS=y
>   CONFIG_NFS_V3_ACL=y
>   CONFIG_NFS_V4=y
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
