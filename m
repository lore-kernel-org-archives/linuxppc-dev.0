Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2AAD3DDEEA
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Feb 2008 01:56:11 +1100 (EST)
Message-Id: <1ADE91E0-282D-4455-9754-886846B3EB90@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: rmcguire@videopresence.com
In-Reply-To: <000001c864c8$4bd81bb0$6405a8c0@absolut>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: 83xx immap_qe.h -> SIR type def error?
Date: Fri, 1 Feb 2008 08:56:00 -0600
References: <mailman.3.1201827605.31777.linuxppc-embedded@ozlabs.org>
	<000001c864c8$4bd81bb0$6405a8c0@absolut>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Feb 1, 2008, at 5:47 AM, Russell McGuire wrote:

> All Freescale,
>
> Not sure if this is the place to post this, but I have run across  
> what I
> consider to be a possible type error in the immap_qe.h file, for the
> asm/powerpc branch.
>
> In the file immap_qe.h
>
> /* SI Routing Tables */
> struct sir {
> 	u8  tx[0x400];
> 	u8  rx[0x400];
> 	u8  res0[0x800];
> }
>
> Shouldn't these types be defined as __be16 ?
>
> According to the Freescale manual this is a 16 bit field, not an 8-bit
> field.
>
> Spent an hour trying to figure out why I couldn't fill this field  
> out with
> upper 8 bits last night.
>
> Thoughts?

I'm guessing it was done this way since they are just looked as base  
offsets.  Where in the UM do you see anything about them being 16-bit  
quantities?  (I'm really know little about this).

- k
