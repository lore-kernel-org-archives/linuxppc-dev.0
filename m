Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s0H5M2Tz3zDqR1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 13:14:15 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id cf3so2715633pad.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 20:14:15 -0700 (PDT)
Received: from balbir.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id r21sm12314347pfi.52.2016.07.27.20.14.11
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 27 Jul 2016 20:14:12 -0700 (PDT)
Subject: Re: [PATCH v3 02/21] powerpc/mm: Move disable_radix handling into
 mmu_early_init_devtree()
To: linuxppc-dev@lists.ozlabs.org
References: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
 <1469629097-30859-2-git-send-email-mpe@ellerman.id.au>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <b6d4386f-3b96-1fd1-a805-5a5ba00dd698@gmail.com>
Date: Thu, 28 Jul 2016 13:14:09 +1000
MIME-Version: 1.0
In-Reply-To: <1469629097-30859-2-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 28/07/16 00:17, Michael Ellerman wrote:
> Move the handling of the disable_radix command line argument into the
> newly created mmu_early_init_devtree().
> 
> It's an MMU option so it's preferable to have it in an mm related file,
> and it also means platforms that don't support radix don't have to carry
> the code.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---

Should patch 1 and 2 be squashed together? Ideally nothing should ever bisect at patch 1

Anyway,
Acked-by: Balbir Singh <bsingharora@gmail.com>
