Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0146.outbound.protection.outlook.com [157.56.110.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6C8FF1A1A34
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 04:59:13 +1000 (AEST)
Message-ID: <1436381938.2658.79.camel@freescale.com>
Subject: Re: [PATCH 2/2] rheap: move rheap.c from arch/powerpc/lib/ to lib/
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang-B45475 <qiang.zhao@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Xie
 Xiaobo-R63061" <X.Xie@freescale.com>
Date: Wed, 8 Jul 2015 13:58:58 -0500
In-Reply-To: <SN1PR0301MB155084FCD058F8EAAC5C5AEA9B910@SN1PR0301MB1550.namprd03.prod.outlook.com>
References: <1432717920-43563-1-git-send-email-B45475@freescale.com>
 <1432717920-43563-2-git-send-email-B45475@freescale.com>
 <1432748213.4089.23.camel@freescale.com>
 <SN1PR0301MB15500729CC3A65394FED67389BB30@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <1433398423.3415.34.camel@freescale.com>
 <SN1PR0301MB1550B0B2F863A80559FE8B6B9BB30@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <1433457659.31070.2.camel@freescale.com>
 <SN1PR0301MB155069ED5F42D54AF2A769F09B910@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <1436324117.2658.64.camel@freescale.com>
 <SN1PR0301MB1550F2C30F1393CA26F4FF3B9B910@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <1436326077.2658.65.camel@freescale.com>
 <SN1PR0301MB155084FCD058F8EAAC5C5AEA9B910@SN1PR0301MB1550.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-07-08 at 02:25 -0500, Zhao Qiang-B45475 wrote:
> So I will add two func for my use, do you think it is ok?
> I need to align the address of allocated muram.
> And I will set algo = gen_pool_first_fit_align.
> 
> +unsigned long gen_pool_alloc_align(struct gen_pool *pool, size_t size,
> +               unsigned long align)

Again, please explain why you need this for CPM/QE.  I don't see 
rh_alloc_align() currently being used by either.

Also, please stop top-posting.

-Scott
