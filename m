Return-Path: <paubert@iram.es>
Received: from gra-vd1.iram.es (gra-vd1.iram.es [150.214.224.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 173C767A46
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Mar 2005 20:23:22 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Mon, 28 Mar 2005 12:16:49 +0200
To: Pavel Fedin <sonic_amiga@rambler.ru>
Message-ID: <20050328101649.GA27913@iram.es>
References: <42485636.4000106@rambler.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42485636.4000106@rambler.ru>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Again ISA DMA question
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 28, 2005 at 02:08:38PM -0500, Pavel Fedin wrote:
>  Hello, all!
> 
>  In a source code or AROS operating system (http://www.aros.org) i 
> found this comment:
> 
>  --- cut ---
>     The older PReP machines have the DMA area limited to first 16MB of 
> system
>     memory. Therefore it is reasonable, to place the kernel at the end 
> of DMA
>     RAM. Both areas may be then easily separated.
>  --- cut ---
> 
>  Does this mean that Linux has an option to limit DMA memory space to 
> first 16 MB? PReP machines are fully supported i guess. Or not fully?

Well, actually if you are courageous, many PreP machines have an
extended ISA DMA with 32 bits addressing capability (this depends
on the ISA bridge). But ISA DMA is only used for floppy and I have 
never connected a floppy to my Prep machines sicne I got the first 
one back in 1997. 

	Regards,
	Gabriel
