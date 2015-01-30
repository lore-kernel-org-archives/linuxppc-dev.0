Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6990A1A0DD7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 23:30:22 +1100 (AEDT)
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D23CF1402AE
 for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2015 23:30:20 +1100 (AEDT)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glppd-linuxppc64-dev@m.gmane.org>)
 id 1YHATX-0000Qt-M8
 for linuxppc-dev@ozlabs.org; Fri, 30 Jan 2015 13:15:03 +0100
Received: from 46.7.2.29 ([46.7.2.29])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2015 13:15:03 +0100
Received: from i by 46.7.2.29 with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2015 13:15:03 +0100
To: linuxppc-dev@ozlabs.org
From: Conor O'Gorman <i@conorogorman.net>
Subject: Re: [PATCH v1 0/3] SHA256 for PPC/SPE
Date: Fri, 30 Jan 2015 12:02:42 +0000
Message-ID: <54CB72E2.1030101@conorogorman.net>
References: <5ad377b3-e491-4c35-8b89-de1dfd0749a6__44574.29146064$1422133918$gmane$org@EXCHANGE.collogia.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
In-Reply-To: <5ad377b3-e491-4c35-8b89-de1dfd0749a6__44574.29146064$1422133918$gmane$org@EXCHANGE.collogia.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 24/01/15 21:10, Markus Stockhausen wrote:
> [PATCH v1 0/3] SHA256 for PPC/SPE
>
> The following patches add support for SIMD accelerated SHA256
> calculation on PPC processors with SPE instruction set. The

Nice boost.

Many of the SoCs with e500 core have crypto hardware accelerators. How 
does this compare?

Thanks,
Conor
