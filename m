Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4FAACDE438
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 00:02:49 +1000 (EST)
In-Reply-To: <fa686aa40710150655s37d8c7d5ye9122034f768a897@mail.gmail.com>
References: <20071014044041.23438.14070.stgit@trillian.cg.shawcable.net>
	<20071014044154.23438.58701.stgit@trillian.cg.shawcable.net>
	<751956FC-6B75-416C-A62A-67915652EA51@kernel.crashing.org>
	<fa686aa40710150655s37d8c7d5ye9122034f768a897@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5D5FEAFA-AFB9-4F8D-941E-11686E8992F4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2 2/7] rheap: Changes config mechanism
Date: Mon, 15 Oct 2007 09:03:17 -0500
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, domen.puncer@telargo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 15, 2007, at 8:55 AM, Grant Likely wrote:

> On 10/15/07, Kumar Gala <galak@kernel.crashing.org> wrote:
>>
>> On Oct 13, 2007, at 11:41 PM, Grant Likely wrote:
>>
>>> From: Sylvain Munaut <tnt@246tNt.com>
>>>
>>> Instead of having in the makefile all the option that
>>> requires rheap, we define a configuration symbol
>>> and when needed we make sure it's selected.
>>>
>>> Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
>>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>>> ---
>>>
>>> +
>>> +config PPC_LIB_RHEAP
>>
>> we should really have help for this option.
>
> This is a non-user-selectable option; none of the other
> non-user-selectable options have help text.

I don't see why we can't let users select it (saying that  
differently, we should let users have this ability)

> I can add a comment; want to give me some text to squirt in there?

grab something out of the comment at the top of lib/rheap.c

- k
