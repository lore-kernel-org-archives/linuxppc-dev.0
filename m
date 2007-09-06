Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 79686DDF44
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 03:50:38 +1000 (EST)
In-Reply-To: <20070906141620.GB16353@ld0162-tx32.am.freescale.net>
References: <20070905192820.GG32398@ld0162-tx32.am.freescale.net>
	<85281ec227e35a9e466e68e3fdc7e6ef@kernel.crashing.org>
	<20070906141620.GB16353@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f26578467468e38345e795ea5f1f7c42@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 8/9] 8xx: Adder 875 support
Date: Thu, 6 Sep 2007 19:50:32 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +	model = "Analogue & Micro Adder MPC875";
>>
>> This should probably be just "MPC875".
>
> There's more than one board with an MPC875 on it.

"model" is the model name the vendor uses.  It isn't supposed to
be unique globally, nor does it say what CPU is on the board.


Segher
