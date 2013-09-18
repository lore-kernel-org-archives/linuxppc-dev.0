Return-Path: <grant.likely@secretlab.ca>
Received: from mail-qa0-f49.google.com (mail-qa0-f49.google.com
 [209.85.216.49])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AE9F82C00F0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Sep 2013 00:51:21 +1000 (EST)
Received: by mail-qa0-f49.google.com with SMTP id k15so2937179qaq.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Sep 2013 07:51:18 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/2] move of_find_next_cache_node to DT core
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1379501585-12532-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1379501585-12532-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Date: Wed, 18 Sep 2013 09:51:16 -0500
Message-Id: <20130918145116.D53A5C42CDF@trevor.secretlab.ca>
Cc: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 18 Sep 2013 11:53:03 +0100, Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com> wrote:
> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> Hi,
> 
> The cache bindings are generic and used by many other architectures
> apart from PPC. These patches fixes and move the existing definition
> of of_find_next_cache_node to DT common code.
> 
> Regards,
> Sudeep

Acked-by: Grant Likely <grant.likely@secretlab.ca>

However, do you have a user for this function on other architectures
yet? I'd like to see a user for the function in the same patch series..

g.

> 
> Sudeep KarkadaNagesha (2):
>   powerpc: remove big endianness assumption in of_find_next_cache_node
>   of: move definition of of_find_next_cache_node into common code.
> 
>  arch/powerpc/include/asm/prom.h |  3 ---
>  arch/powerpc/kernel/prom.c      | 31 -------------------------------
>  drivers/of/base.c               | 31 +++++++++++++++++++++++++++++++
>  include/linux/of.h              |  2 ++
>  4 files changed, 33 insertions(+), 34 deletions(-)
> 
> -- 
> 1.8.1.2
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
