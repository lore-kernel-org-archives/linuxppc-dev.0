Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYNvP2MSzzDsTV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 22:16:33 +1000 (AEST)
In-Reply-To: <1473139963-7496-5-git-send-email-dja@axtens.net>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Daniel Axtens <dja@axtens.net>
Subject: Re: [v2,5/5] powerpc/sparse: Add more assembler prototypes
Message-Id: <3sYNvP02dnz9sxS@ozlabs.org>
Date: Tue, 13 Sep 2016 22:16:32 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-06-09 at 05:32:43 UTC, Daniel Axtens wrote:
> Another set of things that are only called from assembler and so need
> prototypes to keep sparse happy.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0545d5436aefddff7ca417adc1

cheers
