Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v2lkq2sK6zDqRj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 20:52:19 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Cyril Bur <cyrilbur@gmail.com>, Russell Currey <ruscur@russell.cc>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Use octal numbers for file permissions
In-Reply-To: <1484293883.2406.1.camel@gmail.com>
References: <20170112035413.26544-1-ruscur@russell.cc>
 <1484293883.2406.1.camel@gmail.com>
Date: Tue, 17 Jan 2017 20:52:18 +1100
Message-ID: <87a8aqau99.fsf@concordia.ellerman.id.au>
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

> On Thu, 2017-01-12 at 14:54 +1100, Russell Currey wrote:
>> Symbolic macros are unintuitive and hard to read, whereas octal constants
>> are much easier to interpret.  Replace macros for the basic permission
>> flags (user/group/other read/write/execute) with numeric constants
>> instead, across the whole powerpc tree.
>> 
>> Introducing a significant number of changes across the tree for no runtime
>> benefit isn't exactly desirable, but so long as these macros are still
>> used in the tree people will keep sending patches that add them.  Not only
>> are they hard to parse at a glance, there are multiple ways of coming to
>> the same value (as you can see with 0444 and 0644 in this patch) which
>> hurts readability.
>> 
>> Signed-off-by: Russell Currey <ruscur@russell.cc>
>
> Reviewed-by: Cyril Bur <cyrilbur@gmail.com>

Did you really really review every single change?

Because if you did then I don't have to, and that would be *great* :)

cheers
