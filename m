Return-Path: <dja@axtens.net>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyFVr2rLbzDqjs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 17:56:51 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id f127so7296837pgc.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 00:56:51 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>, Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Subject: Re: [PATCH] MAINTAINERS: Remove myself as cxl maintainer
In-Reply-To: <20170628061920.26722-1-imunsie@au.ibm.com>
References: <20170628061920.26722-1-imunsie@au.ibm.com>
Date: Wed, 28 Jun 2017 17:56:44 +1000
Message-ID: <87mv8so88z.fsf@linkitivity.dja.id.au>
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

Hi Ian,

As Andrew said, thanks for everything: CXL enablement was my
introduction to the kernel - it was a great place to start, and it was a
privilege to work with you.

All the best for your future endeavours!

Regards,
Daniel

Ian Munsie <imunsie@au1.ibm.com> writes:

> From: Ian Munsie <imunsie@au1.ibm.com>
>
> I am no longer employed by IBM and will no longer have access to cxl
> hardware, so remove myself as a cxl maintainer.
>
> If anyone needs to contact me in the future, please use my personal
> email address darkstarsword@gmail.com
>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9e984645c4b0..1e8a915577fa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3721,7 +3721,6 @@ S:	Supported
>  F:	drivers/net/ethernet/chelsio/cxgb4vf/
>  
>  CXL (IBM Coherent Accelerator Processor Interface CAPI) DRIVER
> -M:	Ian Munsie <imunsie@au1.ibm.com>
>  M:	Frederic Barrat <fbarrat@linux.vnet.ibm.com>
>  L:	linuxppc-dev@lists.ozlabs.org
>  S:	Supported
> -- 
> 2.11.0
