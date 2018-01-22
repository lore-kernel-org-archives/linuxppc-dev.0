Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zPxqy36qbzF0Wd
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 14:34:22 +1100 (AEDT)
In-Reply-To: <20171226141233.19444-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>, 
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [1/2] powerpc: Fix old-style function definition
Message-Id: <3zPxqx5ztNz9t2f@ozlabs.org>
Date: Mon, 22 Jan 2018 14:34:21 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-12-26 at 14:12:33 UTC, Mathieu Malaterre wrote:
> Fix warnings such as:
> 
> arch/powerpc/platforms/powermac/backlight.c: In function ‘pmac_backlight_get_legacy_brightness’:
> arch/powerpc/platforms/powermac/backlight.c:189:5: error: old-style function definition [-Werror=old-style-definition]
>  int pmac_backlight_get_legacy_brightness()
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/4a7b8a499724c98493023e1e3009aa

cheers
