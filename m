Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7C2BCDDFC3
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 08:04:16 +1000 (EST)
Message-Id: <2A2997EA-F3AF-4C90-8952-42CA48AA07BC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
In-Reply-To: <1209592794.18023.248.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] convert transfer_to_handler into a macro
Date: Wed, 30 Apr 2008 17:04:08 -0500
References: <Pine.LNX.4.64.0804290856210.9230@blarg.am.freescale.net>
	<18455.37613.709102.30668@cargo.ozlabs.ibm.com>
	<73CD5806-5CE4-40A7-957B-8F164E26FAFB@kernel.crashing.org>
	<1209537128.18023.225.camel@pasglop>
	<EDF2E889-4B04-42A8-8D93-E04B35162661@kernel.crashing.org>
	<1209592794.18023.248.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 30, 2008, at 4:59 PM, Benjamin Herrenschmidt wrote:
>
> On Wed, 2008-04-30 at 03:02 -0500, Kumar Gala wrote:
>> got that.  Does 40x/44x have anything similar we need to save/ 
>> restore?
>
> MMUCR I'd say... look at what our tlbie does there...

thanks.  Will take a look.  I just plan on overloading MMUCR with MAS0.

- k
