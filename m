Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8DC24DDDD5
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Oct 2007 01:57:21 +1000 (EST)
In-Reply-To: <1193405129.29250.2.camel@p60635-ste.ids.de>
References: <1193405129.29250.2.camel@p60635-ste.ids.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <77CDBB94-A21E-4A84-9818-4622CB2F572C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: compile warning
Date: Fri, 26 Oct 2007 10:58:15 -0500
To: Sergej Stepanov <Sergej.Stepanov@ids.de>
Cc: linux-ppc <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 26, 2007, at 8:25 AM, Sergej Stepanov wrote:

> Hello!
>
> I have at compile time the following warning:
>
> WARNING: vmlinux.o(.text+0x10f5c): Section mismatch: reference
> to .init.text:cpm_muram_init (between 'cpm2_reset' and
> 'cpm2_smc_clk_setup')
>
> Could it make some problem?

It should be fixed, but its highly unlikely you'll see a problem  
unless you start trying to build core parts of the CPM code as modules.

- k
