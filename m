Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 00DC9DDE02
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jan 2008 09:49:09 +1100 (EST)
Subject: Re: [PATCH 1/2] [POWERPC] smp_call_function_map should be static
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20080101213135.GA1474@lixom.net>
References: <20071228040836.GA23635@lixom.net>
	<1199219313.6751.0.camel@pasglop>  <20080101213135.GA1474@lixom.net>
Content-Type: text/plain
Date: Wed, 02 Jan 2008 09:48:48 +1100
Message-Id: <1199227728.6751.2.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> With the locking changes in 2/2, it will need a new exported function
> that does the locking around the call to __*. With that, it'd be easier
> to just merge this.
> 
> I.e. __smp_call_function_map() will be the internal (lockless) version,
> and you'll end up adding a nonstatic smp_call_function_map() that does
> locking and calls the __* one.
> 
> Is that OK with you?

Yup, it's fine.

Cheers,
Ben.
