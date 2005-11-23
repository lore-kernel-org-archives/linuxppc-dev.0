Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C48D0687D5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Nov 2005 17:09:06 +1100 (EST)
In-Reply-To: <20051123053711.1110.qmail@web50607.mail.yahoo.com>
References: <20051123053711.1110.qmail@web50607.mail.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CE4C7593-EEC8-4817-8ED8-219FAD1FE2A1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Wed, 23 Nov 2005 00:09:47 -0600
To: le tang <le_tang1@yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Linux on MPC8541 and MPC8560
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Nov 22, 2005, at 11:37 PM, le tang wrote:

> Hi,
>
> I got questions on developing the linux on MPC8560 and
> MPC8541.
>
> 1) Which version of linux would be best suited for
> these two processors?

2.6.14 is a good starting point.  Older 2.6 kernels have support for  
MPC8540/MPC8560, I forget when we introduced it.

> 2) Can I make model these two processor accurately
> with device trees on the PSIM?

Extremely unlikely. While I think PSIM has some support for e500 I  
dont think it handles anything close enough to boot linux.

> 3) I have cross compiled gcc with target as
> powerpc-eabi option, and I am using
> powerpc-eabi-objdump to disassemble a pre-compiled
> code, I have tried use -M e500 options, but not sure
> if that would give a very accurate assemly listing.

It should be. The kernel is build with -me500 being passed to the  
assembler. for the majority of code it doesn't matter.  it will  
mainly get proper decode of m{t,f}spr instructions and a few other  
things.

- kumar
