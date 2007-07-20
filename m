Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6EE96DDE36
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 17:58:24 +1000 (EST)
In-Reply-To: <20070720161145.2ff6860c.sfr@canb.auug.org.au>
References: <11849111183072-git-send-email-segher@kernel.crashing.org>
	<20070720161145.2ff6860c.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <86394508-ABAB-4F08-9D41-676C87455D0B@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] of_detach_node()'s device node argument cannot be const
Date: Fri, 20 Jul 2007 09:57:45 +0200
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> ...since it modifies it (when it sets the OF_DETACHED flag).
>
> http://patchwork.ozlabs.org/linuxppc/patch?q=Stephen% 
> 20Rothwell&id=12212

Ah okay :-)


Segher
