Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E5B3FDDEE9
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2009 01:47:55 +1100 (EST)
Message-Id: <9EEF0648-5DCB-47C5-8D69-3095342A43B0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Pieter <phenning@vastech.co.za>
In-Reply-To: <49A26B03.4080300@vastech.co.za>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: Custom kernel driver for MPC8548
Date: Mon, 23 Feb 2009 08:47:48 -0600
References: <49A26B03.4080300@vastech.co.za>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 23, 2009, at 3:23 AM, Pieter wrote:

> Hi all
>
> I recently ported my board to use the new U-boot 2009 and boot Linux
> 2.6.27. ( the previous Linux version was 2.6.19 which supported the  
> ppc
> architecture)
>
> I am now at the stage where I need to port a custom platform driver.  
> The
> driver used files that resided in /include/asm-ppc/. which are no  
> longer
> available using the powerpc architecture. Can someone please guide  
> me as
> to where to look for the appropriate contents?
>
> In particular:
> asm-ppc/io.h
> asm-ppc/mpc85xx.h
> asm-ppc/immap_85xx.h

look in arch/powerpc/include/asm/

- k
