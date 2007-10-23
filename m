Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E66EBDDECE
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 10:58:07 +1000 (EST)
In-Reply-To: <20071023003309.GE31839@localhost.localdomain>
References: <E1Iivsg-00078a-Vp@jdl.com>
	<20d6133a9294d4f06a7e78ca627ec4f3@kernel.crashing.org>
	<E1IjwWf-0000dJ-45@jdl.com>
	<20071023003309.GE31839@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a2dc4530efef0e434975b135e3d6ed35@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 4/4] DTC: Begin the path to sane literals and expressions.
Date: Tue, 23 Oct 2007 02:57:51 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> Property names have been limited to start with
>>>> characters from the set [a-zA-Z,._#?].  That is, the
>>>> digits and the expression symbols have been removed.
>>>
>>> This cannot work; many property names start with a digit,
>>> for example.
>>
>> Are any of those property names in use in any
>> of our DTS files or b-w-o.txt?  Not really, no.
>> In fact, with this lexical change, all of our
>> DTS files still produce byte-identical results.
>>
>> I really think this is one of those areas where
>> we may need to stray from the other guideline.
>>
>> Is there a compelling reason somewhere?  Really?
>
> We may have deprecated te '64-bit' and '32-64-bridge' properties in
> cpu nodes for the flattened tree, but it already exists in a great
> number of Apple and IBM trees.

Huh?  "64-bit" isn't deprecated I hope, just the "32-bit" thing
(that never was defined) is.

> It would be poor form for dtc to choke on these trees.

Yah.  Small incompatibilities add up :-(


Segher
