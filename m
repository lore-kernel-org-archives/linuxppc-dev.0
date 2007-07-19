Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B2FF9DDEE1
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 02:58:47 +1000 (EST)
In-Reply-To: <20070719155207.GA28617@ld0162-tx32.am.freescale.net>
References: <20070718173024.50204a1a.sfr@canb.auug.org.au>
	<20070720010742.e60c67a7.sfr@canb.auug.org.au>
	<20070720011012.4eca281d.sfr@canb.auug.org.au>
	<20070719155207.GA28617@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3E555E76-1182-4C67-9368-E7E0F4756E69@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 03/12] Consolidate of_device_is_compatible
Date: Thu, 19 Jul 2007 18:58:27 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, wli@holomorphy.com,
	ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org,
	sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> The only difference here is that Sparc uses strncmp to match  
>> compatibility
>> names while PowerPC uses strncasecmp.
>
> Could we put a comment in saying that both should really just use
> strcmp(), and that this mechanism should go away once any  
> compatibility
> issues are found and addressed?
>
> The PowerPC one will need to drop the 'n' soon, as well, but that  
> should
> be a separate patch.

I think both of these are on enough to-do lists that adding
a comment isn't necessary ;-)


Segher
