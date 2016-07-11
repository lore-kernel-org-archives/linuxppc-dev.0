Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpM8312XwzDqwH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 09:42:11 +1000 (AEST)
Date: Tue, 12 Jul 2016 09:41:49 +1000
From: Anton Blanchard <anton@samba.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/configs: Enable VMX crypto
Message-ID: <20160712094149.21a28e0d@kryten>
In-Reply-To: <20160712093317.0c3ab74e@canb.auug.org.au>
References: <1468279521-9720-1-git-send-email-anton@ozlabs.org>
 <20160712093317.0c3ab74e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Steven,

> Not in ppc64_defconfig?

Good point. The recent addition of powernv_defconfig made me forget
about ppc64_defconfig. We could do with some rationalisation here.

pseries isn't really pseries, perhaps we should call it ibm_defconfig,
or maybe server_deconfig. ppc64_defconfig continues to be the lower end
defconfig.

Anton
