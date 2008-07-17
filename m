Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5C4B9DE8B3
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 22:40:27 +1000 (EST)
Message-Id: <24711C36-2DDC-412D-AE1D-58A458838356@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <36B8084A-B0E4-48D5-97FD-05DD68D4A5D8@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH 3/3] powerpc: Use PPC_LONG and PPC_LONG_ALIGN in
	lib/string.S
Date: Thu, 17 Jul 2008 07:36:46 -0500
References: <3756cbfb076b2fa0b93ec990aabfee73296443d9.1216279070.git.michael@ellerman.id.au>
	<27c8ac7aceccaf7856c65f2ef1305321f94d564e.1216279070.git.michael@ellerman.id.au>
	<36B8084A-B0E4-48D5-97FD-05DD68D4A5D8@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 17, 2008, at 7:28 AM, Kumar Gala wrote:

>
> On Jul 17, 2008, at 2:17 AM, Michael Ellerman wrote:
>
>> No change to the generated code.
>>
>> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
>> ---
>> arch/powerpc/lib/string.S |   18 ++++++------------
>> 1 files changed, 6 insertions(+), 12 deletions(-)
>
>
> What's the reason for the change?


ignore me.. when I look closer its obvious.

- k
