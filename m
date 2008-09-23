Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C7F13DDEE1
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 15:47:32 +1000 (EST)
Subject: Re: Problems with macros LOAD_REG_ADDR and LOAD_REG_IMMEDIATE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Mitesh R. Meswani" <mmeswani@miners.utep.edu>
In-Reply-To: <BLU103-DS7C4EEE573B423B715F520934B0@phx.gbl>
References: <BLU103-DS7C4EEE573B423B715F520934B0@phx.gbl>
Content-Type: text/plain
Date: Tue, 23 Sep 2008 15:47:25 +1000
Message-Id: <1222148845.12085.99.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-09-22 at 12:16 -0600, Mitesh R. Meswani wrote:
> I am having issues using LOAD_REG_ADDR and LOAD_REG_IMMEDIATE macros
> on a ppc64 kernel which I have tried on both 2.6.16 and 2.6.17
> kernels. 
>  
> I noticed that these macros by default loading value 0 instead of the
> actual address. Is this a bug of the compiler that can be fixed, I
> noticed when I did objdump for head_64.S on the following function 
> _GLOBAL(pSeries_secondary_smp_init) for the following instruction :
> LOAD_REG_IMMEDIATE(r13, paca)   /* Get base vaddr of paca array  */   
>  
> I noticed this in some calls, whereas some calls seem to get symbol address. 

How did you "notice" that ?

Ben.
