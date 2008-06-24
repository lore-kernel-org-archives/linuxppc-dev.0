Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0D724DDF0C
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 23:40:09 +1000 (EST)
Message-Id: <A26AA14B-2BE1-4E58-8C83-0F2399DE9D4D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <d66e1bcc6428a3fde7665e09ded9a9331f5b480d.1214271072.git.michael@ellerman.id.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 04/14] powerpc: Add ppc_function_entry() which gets the
	entry point for a function
Date: Tue, 24 Jun 2008 08:39:52 -0500
References: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
	<d66e1bcc6428a3fde7665e09ded9a9331f5b480d.1214271072.git.michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 23, 2008, at 8:32 PM, Michael Ellerman wrote:

> Because function pointers point to different things on 32-bit vs 64- 
> bit,
> add a macro that deals with dereferencing the OPD on 64-bit. The  
> soon to
> be merged ftrace wants this, as well as other code I am working on.
>
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k
