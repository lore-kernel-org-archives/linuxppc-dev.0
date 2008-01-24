Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 7EFE6DDF28
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 01:27:18 +1100 (EST)
Message-ID: <4798A043.2060006@windriver.com>
Date: Thu, 24 Jan 2008 09:27:15 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 0/7] Powerpc support for SBC8560 board
References: <11997159321859-git-send-email-paul.gortmaker@windriver.com>
	<9C12D718-CEE4-4533-BD88-F3F8A4CA0BE9@kernel.crashing.org>
	<47989DED.8010303@windriver.com>
	<FF6CE4C3-5ED3-4FDB-9067-DACB60E80E3E@kernel.crashing.org>
In-Reply-To: <FF6CE4C3-5ED3-4FDB-9067-DACB60E80E3E@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
>
> On Jan 24, 2008, at 8:17 AM, Paul Gortmaker wrote:
>
>> Kumar Gala wrote:
>>>
>>> Have we closed on these patches?
>>>
>>> the sbc8560 is the last board that we need to close on for me to 
>>> kill 85xx in arch/ppc.
>>
>> I think so. For the 8560, the last issue was David wanting
>> the dts to have the address cells =2 on localbus-like nodes
>> and I've not heard any negative feedback on how I did it (yet).
>>
>> I'll resend the 8xxx patches as a lump today for the sake
>> of merge convenience, with the legacy_serial change and the
>> extra simplebus that Scott asked for factored out separate.
>
> ok that would be great. Will that include an updated sbc834x set?

Yes, the sbc834x, sbc8548 and sbc8560.

Thanks,
Paul.

>
> - k
