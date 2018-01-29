Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zVln36KkDzDqs9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jan 2018 10:18:31 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
 Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Colin Leroy <colin@colino.net>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: macintosh: change some data types from int to bool
In-Reply-To: <20180129050920.Horde.QLe9K1M-r7blMvmzflyFRGC@gator4166.hostgator.com>
References: <20180124014228.GA26899@embeddedgus> <3zVGNG6B8Hz9t5Y@ozlabs.org>
 <20180129050920.Horde.QLe9K1M-r7blMvmzflyFRGC@gator4166.hostgator.com>
Date: Tue, 30 Jan 2018 10:18:28 +1100
Message-ID: <87shao8da3.fsf@concordia.ellerman.id.au>
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

"Gustavo A. R. Silva" <garsilva@embeddedor.com> writes:

> Hi Michael,
>
> Quoting Michael Ellerman <patch-notifications@ellerman.id.au>:
>
>> On Wed, 2018-01-24 at 01:42:28 UTC, "Gustavo A. R. Silva" wrote:
>>> Change the data type of the following variables from int to bool
>>> across all macintosh drivers:
>>>
>>> started
>>> slots_started
>>> pm121_started
>>> wf_smu_started
>>>
>>> Some of these issues were detected with the help of Coccinelle.
>>>
>>> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>
>> Applied to powerpc next, thanks.
>>
>> https://git.kernel.org/powerpc/c/4f256d561447c6e1bf8b70e19daae0
>>
>> cheers
>
> Awesome.
>
> If I can help out with anything else, please let me know.

Sure thing.

We have a TODO list of sorts on github, some of them are easy, some are
not, feel free to ask here or on an individual issue for help:

  https://github.com/linuxppc/linux/issues

cheers
