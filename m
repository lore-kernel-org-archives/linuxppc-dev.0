Return-Path: <vinod.koul@intel.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZ2GX0Td5zDsW5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 23:20:20 +1000 (AEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3sZ2GW2FX7z9ssP
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Sep 2016 23:20:18 +1000 (AEST)
Date: Wed, 14 Sep 2016 18:58:36 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: dan.j.williams@intel.com, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, arnd@arndb.de
Subject: Re: [PATCH] drivers/dma: NO_IRQ removal from powerpc-only drivers
Message-ID: <20160914132835.GG13920@localhost>
References: <1473501364-6575-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473501364-6575-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Sep 10, 2016 at 07:56:04PM +1000, Michael Ellerman wrote:
> We'd like to eventually remove NO_IRQ on powerpc, so remove usages of it
> from powerpc-only drivers.

Applied after fixing subsystem name

-- 
~Vinod
