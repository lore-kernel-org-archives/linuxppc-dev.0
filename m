Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3cNn55NwzDq9B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 20:24:57 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>,
 Michael Ellerman <patch-notifications@ellerman.id.au>,
 Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: Avoid taking a data miss on every userspace instruction
 miss
In-Reply-To: <1492046172.8380.16.camel@gmail.com>
References: <3vzNHv6zMZz9s9c@ozlabs.org> <1492046172.8380.16.camel@gmail.com>
Date: Thu, 13 Apr 2017 20:24:56 +1000
Message-ID: <87zifk8v0n.fsf@concordia.ellerman.id.au>
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

Balbir Singh <bsingharora@gmail.com> writes:

> On Thu, 2017-04-06 at 23:06 +1000, Michael Ellerman wrote:
>> On Mon, 2017-04-03 at 06:41:02 UTC, Anton Blanchard wrote:
>> > From: Anton Blanchard <anton@samba.org>
>> > 
>> Applied to powerpc next, thanks.
>> 
>> https://git.kernel.org/powerpc/c/a7a9dcd882a67b68568868b988289f
>>
>
> FYI: The version you applied does not have checks for is_write

The version I was sent didn't have it :)

cheers
