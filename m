Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDF8f4qNNzDq72
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 21:29:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Alastair D'Silva <alastair@au1.ibm.com>, linuxppc-dev@ozlabs.org
Cc: Alastair D'Silva <alastair@d-silva.org>, frederic.barrat@fr.ibm.com
Subject: Re: [PATCH v2] cxl: Prevent IRQ storm
In-Reply-To: <19926571-7158-0ad8-4bf4-aa20abf23092@au1.ibm.com>
References: <20170427013721.2138-1-alastair@au1.ibm.com>
 <19926571-7158-0ad8-4bf4-aa20abf23092@au1.ibm.com>
Date: Thu, 27 Apr 2017 21:29:20 +1000
Message-ID: <87a8721433.fsf@concordia.ellerman.id.au>
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

Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:

> On 27/04/17 11:37, Alastair D'Silva wrote:
>> From: Alastair D'Silva <alastair@d-silva.org>
>>
>> In some situations, a faulty AFU slice may create an interrupt storm,
>> rendering the machine unusable. Since these interrupts are informational
>> only, present the interrupt once, then mask it off to prevent it from
>> being retriggered until the card is reset.
>>
>> Changelog:
>> v2
>> 	Rebase against linux-next
>
> The patch changelog shouldn't be part of the commit message - it should 
> go under a "---" line after the sign-off so it doesn't get included in 
> the final commit.
>
> Also now that I've taken a second look, I think the summary line of the 
> commit message could be more descriptive, something like:
>
> "cxl: mask slice error interrupt after first occurrence"
        ^
        M

:D

cheers
