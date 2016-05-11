Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4PGD3nQpzDqCQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 15:05:56 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id yl2so2731647pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 22:05:56 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] powerpc/timer - large decrementer support
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <1462856240-20648-1-git-send-email-oohall@gmail.com>
Cc: Michael Neuling <mikey@neuling.org>, Jack Miller <jack@codezen.org>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <8cf18635-b9ac-1b6a-ac8b-3a2bf748cb47@gmail.com>
Date: Wed, 11 May 2016 15:05:49 +1000
MIME-Version: 1.0
In-Reply-To: <1462856240-20648-1-git-send-email-oohall@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 10/05/16 14:57, Oliver O'Halloran wrote:
> POWER ISA v3 adds large decrementer (LD) mode of operation which increases
> the size of the decrementer register from 32 bits to an implementation
> defined with of up to 64 bits.
> 
> This patch adds support for the LD on processors with the CPU_FTR_ARCH_300
> cpu feature flag set. For CPUs with this feature LD mode is enabled when
> when the ibm,dec-bits devicetree property is supplied for the boot CPU. The
> decrementer value is a signed quantity (with negative values indicating a
> pending exception) and this property is required to find the maximum
> positive decrementer value. If this property is not supplied then the
> traditional decrementer width of 32 bits is assumed and LD mode is disabled.
> 
> This patch was based on initial work by Jack Miller.
> 
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> Cc: Michael Neuling <mikey@neuling.org>
> Cc: Balbir Singh <bsingharora@gmail.com>
> Cc: Jack Miller <jack@codezen.org>

These bits look good mostly

Reviewed-by: Balbir Singh <bsingharora@gmail.com>
