Return-Path: <aik@ozlabs.ru>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 416ZHC4hTPzF10j
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2018 19:01:43 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id c23-v6so5022099plz.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2018 02:01:43 -0700 (PDT)
Date: Fri, 15 Jun 2018 19:01:33 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alistair Popple <alistair@popple.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Russell Currey <ruscur@russell.cc>
Subject: Re: [PATCH kernel 0/2] powerpc/powernv: Rework sketchy bypass
Message-ID: <20180615190133.7af45d3a@aik.ozlabs.ibm.com>
In-Reply-To: <20180601081028.29401-1-aik@ozlabs.ru>
References: <20180601081028.29401-1-aik@ozlabs.ru>
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

On Fri,  1 Jun 2018 18:10:26 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> I came across this adhoc implementation and thought it could use some
> polishing. This fixes memory leaks and add P9 support. Based on the current
> upstream.
> 
> 
> Please comment. Thanks.


Ping?


> 
> 
> 
> Alexey Kardashevskiy (2):
>   powerpc/powernv: Reuse existing TCE code for sketchy bypass
>   powerpc/powernv: Define PHB4 type and enable sketchy bypass on POWER9
> 
>  arch/powerpc/platforms/powernv/pci.h      |  1 +
>  arch/powerpc/platforms/powernv/pci-ioda.c | 76 +++++++++++++++++--------------
>  2 files changed, 44 insertions(+), 33 deletions(-)
> 



--
Alexey
