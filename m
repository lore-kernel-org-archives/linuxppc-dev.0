Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvjVr5KHLzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 11:46:44 +1000 (AEST)
Message-ID: <1461721589.3586.0.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mm: Use jump label to speed up radix_enabled check
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Balbir Singh <bsingharora@gmail.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Date: Wed, 27 Apr 2016 11:46:29 +1000
In-Reply-To: <57200F4A.4070104@gmail.com>
References: <1461687855-23017-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1461704701.3135.68.camel@kernel.crashing.org> <571FE8C1.4030903@gmail.com>
 <1461711943.3135.72.camel@kernel.crashing.org> <57200F4A.4070104@gmail.com>
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

On Wed, 2016-04-27 at 11:00 +1000, Balbir Singh wrote:
> Just basic testing across CPUs with various mm features 
> enabled/disabled. Just for sanity

I still don't think it's worth scattering the change. Either the jump
label works or it doesn't ... The only problem is make sure we identify
all the pre-boot ones but that's about it.

Cheers,
Ben.
