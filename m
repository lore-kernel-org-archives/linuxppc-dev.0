Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D52642C011D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jul 2013 18:50:22 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 15 Jul 2013 14:15:13 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 83EA71258052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jul 2013 14:19:34 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6F8oud631654058
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jul 2013 14:20:56 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6F8oESd017115
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jul 2013 18:50:15 +1000
Message-ID: <51E3B6FB.7040002@linux.vnet.ibm.com>
Date: Mon, 15 Jul 2013 14:16:51 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] powerpc/pseries: drop "select HOTPLUG"
References: <1373799735.1370.5.camel@x61.thuisdomein>
In-Reply-To: <1373799735.1370.5.camel@x61.thuisdomein>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/14/2013 04:32 PM, Paul Bolle wrote:
> The Kconfig symbol HOTPLUG was removed with commit 40b313608a ("Finally
> eradicate CONFIG_HOTPLUG"). But there's still one select statement for
> that symbol. It seems that select statement was added after the patch to
> remove CONFIG_HOTPLUG was submitted. Anyhow, it is useless and can be
> dropped.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---

Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

> 
>  arch/powerpc/platforms/pseries/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
> index 1bd3399..62b4f80 100644
> --- a/arch/powerpc/platforms/pseries/Kconfig
> +++ b/arch/powerpc/platforms/pseries/Kconfig
> @@ -19,7 +19,6 @@ config PPC_PSERIES
>  	select ZLIB_DEFLATE
>  	select PPC_DOORBELL
>  	select HAVE_CONTEXT_TRACKING
> -	select HOTPLUG if SMP
>  	select HOTPLUG_CPU if SMP
>  	default y
> 

Regards,
Srivatsa S. Bhat
