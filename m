Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wn9Dd5VxPzDqNd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 23:13:05 +1000 (AEST)
Date: Tue, 13 Jun 2017 15:04:00 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Masahiro Yamada <yamada.masahiro@socionext.com>, Michael Ellerman
 <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] powerpc: dts: use #include "..." to include local DT
Message-ID: <20170613150400.3958162c@crub>
In-Reply-To: <1495602744-18874-1-git-send-email-yamada.masahiro@socionext.com>
References: <1495602744-18874-1-git-send-email-yamada.masahiro@socionext.com>
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

Hi,

On Wed, 24 May 2017 14:12:24 +0900
Masahiro Yamada yamada.masahiro@socionext.com wrote:

>Most of DT files in PowerPC use #include "..." to make pre-processor
>include DT in the same directory, but we have 3 exceptional files
>that use #include <...> for that.
>
>Fix them to remove -I$(srctree)/arch/$(SRCARCH)/boot/dts path from
>dtc_cpp_flags.
>
>Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Tested-by: Anatolij Gustschin <agust@denx.de>
