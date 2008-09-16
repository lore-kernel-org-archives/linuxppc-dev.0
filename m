Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 154DADE506
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Sep 2008 04:38:17 +1000 (EST)
Message-Id: <09B935AC-1A79-4887-8E8C-5B68EA427AE0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
In-Reply-To: <1221589869.12463.42.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH v5 1/4] powerpc: Introduce local (non-broadcast) forms of
	tlb invalidates
Date: Tue, 16 Sep 2008 13:38:09 -0500
References: <1221578145-29102-1-git-send-email-galak@kernel.crashing.org>
	<1221589869.12463.42.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 16, 2008, at 1:31 PM, Benjamin Herrenschmidt wrote:

>
>> static inline void flush_tlb_kernel_range(unsigned long start,
>> 					  unsigned long end)
>> {
>> -	_tlbia();
>> +	_tlbil_all();
>> }
>
> I love making you respin your patches so what about the one above
> becomes tlbil_pid(0) ? :-)

its what I get for spinning patches first thing in the morning...

lets see if you like v6 :)

- k
