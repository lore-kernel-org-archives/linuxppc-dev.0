Return-Path: <sjennings@variantweb.net>
Received: from relay.variantweb.net (unknown [104.131.199.242])
 by lists.ozlabs.org (Postfix) with ESMTP id A43F91A0337
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Oct 2014 19:09:56 +1100 (AEDT)
Message-ID: <c5208e76ca917ccb0ca7c5fd5953cf21.squirrel@www.variantweb.net>
In-Reply-To: <f05dbb0844d1f0431532a186b56034f3.squirrel@www.variantweb.net>
References: <1413487819-6119-1-git-send-email-ddstreet@ieee.org>
 <1413499435.28062.2.camel@concordia> <1413499949.4567.3.camel@pasglop>
 <f05dbb0844d1f0431532a186b56034f3.squirrel@www.variantweb.net>
Date: Fri, 17 Oct 2014 08:02:17 -0000
Subject: Re: [PATCH] drivers/crypto/nx: prevent oops on module exit
From: "Seth Jennings" <sjennings@variantweb.net>
To: sjennings@variantweb.net
Reply-To: sjennings@variantweb.net
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: Robert Jennings <rcj4747@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Dan Streetman <ddstreet@ieee.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> On Fri, 2014-10-17 at 09:43 +1100, Michael Ellerman wrote:
>>> On Thu, 2014-10-16 at 15:30 -0400, Dan Streetman wrote:
>>> > Check old_devdata->dev in nx-842 driver before accessing it, as
>>> > on systems without any nx-842 hardware, the ->dev will never be
>>> > set.  Currently, the module will cause an oops during unload
>>> > since old_devdata->dev is null.
>>>
>>> Hi Dan,
>>>
>>> Patch looks reasonable. But I can't merge it, at least not without an
>>> ACK:
>>>
>>> $ ./scripts/get_maintainer.pl -f drivers/crypto/nx/
>>> Nathan Fontenot <nfont@linux.vnet.ibm.com> (supporter:IBM Power 842
>>> com...)
>>> Marcelo Henrique Cerri <mhcerri@linux.vnet.ibm.com> (supporter:IBM
>>> Power
>>> in-Nest...)
>>> Fionnuala Gunter <fin@linux.vnet.ibm.com> (supporter:IBM Power
>>> in-Nest...)
>>> Herbert Xu <herbert@gondor.apana.org.au> (maintainer:CRYPTO API)
>>> "David S. Miller" <davem@davemloft.net> (maintainer:CRYPTO API)
>>> linux-crypto@vger.kernel.org (open list:IBM Power in-Nest...)
>>> linux-kernel@vger.kernel.org (open list)
>>>
>>>
>>> If any of the above is out of date please send me a patch for
>>> MAINTAINERS.
>>
>> I think Dan now owns that driver, Dan, please confirm.
>
> I guess I'm not on the maintainer list anymore, as I shouldn't be
> since I don't work at IBM anymore.

Wow, I messed that up.  Repeating myself :-/  Sorry for the noise.

Seth

>
> So... yeah.  I was the original co-author of driver so I acked it
> but I'm not the maintainer anymore.  Which I shouldn't be, since
> I don't work at IBM anymore.
>
> Seth
>
>>
>> Cheers,
>> Ben.
>>
>>
>>
>
>
