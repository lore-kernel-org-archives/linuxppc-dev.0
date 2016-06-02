Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rKzg75ffHzDqcV
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 17:41:07 +1000 (AEST)
Message-ID: <1464853260.19646.6.camel@ellerman.id.au>
Subject: Re: [PATCH 1/3] powerpc: export cpu_to_core_id()
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Date: Thu, 02 Jun 2016 17:41:00 +1000
In-Reply-To: <201606012016.u51KDwr8046821@mx0a-001b2d01.pphosted.com>
References: <201606012016.u51KDwr8046821@mx0a-001b2d01.pphosted.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-06-01 at 17:16 -0300, Mauricio Faria de Oliveira wrote:

> Export cpu_to_core_id().  This will be used by the lpfc driver.

Can you explain why?

I would have thought there'd be architecture neutral APIs you can use - and if
there aren't maybe we should write them.

cheers
