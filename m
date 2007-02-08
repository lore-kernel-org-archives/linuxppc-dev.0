Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0193EDDDE6
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 16:19:52 +1100 (EST)
In-Reply-To: <32F3CC26D4DAC44E8ECD07155727A46E8B7DFC@zch01exm20.fsl.freescale.net>
References: <32F3CC26D4DAC44E8ECD07155727A46E8B7DFC@zch01exm20.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5B698A5A-5A2D-47D2-B1E0-32D93AD2A391@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch][0/5] powerpc V2 : Add support to fully comply with
	IEEE-754 standard
Date: Wed, 7 Feb 2007 23:18:53 -0600
To: Zhu Ebony-r57400 <ebony.zhu@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 7, 2007, at 9:50 PM, Zhu Ebony-r57400 wrote:

> Hi Paul,
>
> These are the re-sent patches to add support to fully comply with
> IEEE-754 standard for E500/E500v2 core when hardware floating
> point compiling is used. Comparison with last patches I've submitted,
> the following points was changed:
>
> 1. Add a rounding exception handler, to handle the exceptions that
> would occur when rounding towards +Inf/-Inf
>
> 2. Using the existing exception entering/returning routine, and get  
> the
> exception
> instructions from regs->nip instead of reading from SRR0
>
> Thank you all for the comments you gave to me!

Did you end up getting testfloat running?  I'd like to see some  
testing results before accepting these patches.  I think testfloat is  
our best bet at this point.

- k
