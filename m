Return-Path: <garsilva@embeddedor.com>
Received: from gateway36.websitewelcome.com (gateway36.websitewelcome.com
 [192.185.201.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zVS6T4qHGzDqjD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 22:32:33 +1100 (AEDT)
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
 by gateway36.websitewelcome.com (Postfix) with ESMTP id B57DA400EE319
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 05:09:20 -0600 (CST)
Date: Mon, 29 Jan 2018 05:09:20 -0600
Message-ID: <20180129050920.Horde.QLe9K1M-r7blMvmzflyFRGC@gator4166.hostgator.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Colin Leroy
 <colin@colino.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: macintosh: change some data types from int to bool
References: <20180124014228.GA26899@embeddedgus> <3zVGNG6B8Hz9t5Y@ozlabs.org>
In-Reply-To: <3zVGNG6B8Hz9t5Y@ozlabs.org>
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

Quoting Michael Ellerman <patch-notifications@ellerman.id.au>:

> On Wed, 2018-01-24 at 01:42:28 UTC, "Gustavo A. R. Silva" wrote:
>> Change the data type of the following variables from int to bool
>> across all macintosh drivers:
>>
>> started
>> slots_started
>> pm121_started
>> wf_smu_started
>>
>> Some of these issues were detected with the help of Coccinelle.
>>
>> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>
> Applied to powerpc next, thanks.
>
> https://git.kernel.org/powerpc/c/4f256d561447c6e1bf8b70e19daae0
>
> cheers

Awesome.

If I can help out with anything else, please let me know.

Thank you
--
Gustavo
