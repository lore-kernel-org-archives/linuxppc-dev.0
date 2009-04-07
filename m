Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 70C82DDF86
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 17:05:08 +1000 (EST)
Message-Id: <789360B9-B0AD-4BE4-85FE-1151107B7E3A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1239086621.6565.25.camel@localhost>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc: Add support for early tlbilx opcode
Date: Tue, 7 Apr 2009 02:04:56 -0500
References: <1239084821-10121-1-git-send-email-galak@kernel.crashing.org>
	<1239086621.6565.25.camel@localhost>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 7, 2009, at 1:43 AM, Michael Ellerman wrote:

>
> You're actually going to ship those parts? :)

I hope not, but until someone tells me otherwise I want the fix in  
(less headache for me).  We can easily revert this one commit if it  
becomes clear that such parts "never really existed". ;)

> It seems a pity to use up a feature bit.

MMU feature bits are new so we have a slew of them :)

- k
