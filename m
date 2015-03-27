Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6C6731A06B9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2015 21:07:06 +1100 (AEDT)
In-Reply-To: <5513E3A0.6060001@linux.vnet.ibm.com>
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: cxl: Fix a typo in ABI documentation
Message-Id: <20150327100706.5A9271400D5@ozlabs.org>
Date: Fri, 27 Mar 2015 21:07:06 +1100 (AEDT)
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-26-03 at 10:46:56 UTC, Philippe Bergheaud wrote:
> Fix the attribute name of the configuration record class ID.
> 
> Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
> ---
>   Documentation/ABI/testing/sysfs-class-cxl | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-cxl b/Documentation/ABI/testing/sysfs-class-cxl
> index 3680364..d46bba8 100644
> --- a/Documentation/ABI/testing/sysfs-class-cxl
> +++ b/Documentation/ABI/testing/sysfs-class-cxl
> @@ -100,7 +100,7 @@ Description:    read only
>   		Hexadecimal value of the device ID found in this AFU
>   		configuration record.
> 
> -What:           /sys/class/cxl/<afu>/cr<config num>/vendor
> +What:           /sys/class/cxl/<afu>/cr<config num>/class
>   Date:           February 2015
>   Contact:        linuxppc-dev@lists.ozlabs.org
>   Description:    read only

White space is fubar.

I fixed it up and applied it anyway.

cheers
