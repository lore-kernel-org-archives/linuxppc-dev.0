Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9B7AADDE25
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 13:58:47 +1100 (EST)
Message-Id: <B8174DB6-6144-44CA-AA82-5438FBA0DA8E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080124201939.GB3926@loki.buserror.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] [POWERPC] 85xx: Port STX GP3 board over from arch/ppc
Date: Thu, 24 Jan 2008 20:58:29 -0600
References: <Pine.LNX.4.64.0801240041530.22238@blarg.am.freescale.net>
	<20080124201939.GB3926@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> @@ -49,7 +57,7 @@ config MPC8540
>> config MPC8560
>> 	bool
>> 	select CPM2
>> -	default y if MPC8560_ADS
>> +	default y if MPC8560_ADS || STX_GP3
>
> Can we select this from 8560 boards, instead of a default y list?

I'll rework the whole Kconfig after all these board ports go in.

>
- k
