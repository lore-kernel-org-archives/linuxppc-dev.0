Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4jzK3m72zDqQ1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 18:39:25 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Cyril Bur <cyrilbur@gmail.com>, Jack Miller <jack@codezen.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: stewart@linux.vnet.ibm.com, jk@ozlabs.org
Subject: Re: [PATCH v2] powernv: Simplify searching for compatible device nodes
In-Reply-To: <20160804172727.55e81056@camb691>
References: <20160803164412.7039-1-jack@codezen.org>
 <20160803171800.8999-1-jack@codezen.org> <20160804172727.55e81056@camb691>
Date: Thu, 04 Aug 2016 18:39:24 +1000
Message-ID: <87k2fxexmr.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cyril Bur <cyrilbur@gmail.com> writes:

> On Wed,  3 Aug 2016 12:18:00 -0500
> Jack Miller <jack@codezen.org> wrote:
>
>> (rebased on powerpc/next)
>> 
>> This condenses the opal node searching into a single function that finds
>> all compatible nodes, instead of just searching the ibm,opal children,
>> for ipmi, flash, and prd similar to how opal-i2c nodes are found.
>> 
>> Signed-off-by: Jack Miller <jack@codezen.org>
>
> Using a version of the related skiboot patch that may not be the final one:
> Tested-by: Cyril Bur <cyrilbur@gmail.com>

Thanks. The part I'm still not clear on is *why* we're moving them in
skiboot?

cheers
