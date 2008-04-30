Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 83C27DDFC8
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 09:24:44 +1000 (EST)
Message-Id: <443B3050-8332-451D-8B79-28CC1C3AEB15@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
In-Reply-To: <1209593896.18023.253.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] Rework EXC_LEVEL_EXCEPTION_PROLOG code
Date: Wed, 30 Apr 2008 18:24:37 -0500
References: <Pine.LNX.4.64.0804300424040.31028@blarg.am.freescale.net>
	<1209592495.18023.246.camel@pasglop>
	<12ECF63E-7CEA-48FD-9447-7D534C29271D@kernel.crashing.org>
	<1209593896.18023.253.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 30, 2008, at 5:18 PM, Benjamin Herrenschmidt wrote:
>
> On Wed, 2008-04-30 at 17:13 -0500, Kumar Gala wrote:
>>>> stack there by make references go from GPR11-INT_FRAME_SIZE(r8) to
>>>> just GPR(r8)
>>>           ^^ 11 ?
>>
>> r8 is correct for my example.  My point is
>> s/GPR11-INT_FRAME_SIZE/GPR11/
>
> Sorry, I put the ^^ in the wrong place :-) I meant the example should
> say GPR11(r8)

ah, that makes sense.  Will fix in the next revision.

- k
