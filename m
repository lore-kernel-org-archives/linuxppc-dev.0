Return-Path: <antonio.dibacco@aruba.it>
Received: from smtpa3.aruba.it (smtpa4.aruba.it [62.149.128.201])
	by ozlabs.org (Postfix) with SMTP id 544A167A40
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Jun 2006 08:20:52 +1000 (EST)
From: Antonio Di Bacco <antonio.dibacco@aruba.it>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: 8xx spi completion sometime doesn't generate an interrupt
Date: Sat, 3 Jun 2006 00:21:58 +0200
References: <20060602204540.BE50D353A57@atlas.denx.de>
In-Reply-To: <20060602204540.BE50D353A57@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200606030021.58892.antonio.dibacco@aruba.it>
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

> Yes, this is known problem, especially if you are runnign the SPI bus
> with higher data transfer rates and/or high CPM load ....

I lowered the SPI bus frequency, the interrupt is now always happening but I 
have always problems.
I did further investigations, I'm doing spi transfers of 256 bytes both 
writing and reading (256 is the size of a page of the chip). I write one time 
and then read two times the complete 8Mbit chip. The two reading give me 
always the same result, then, the writing is failing in my case. Probably I 
have to double check the writing procedure. But it is also worth to note that 
changing the PM (prescaler module) and lowering the SPI clock even more the 
writing problem is happening less frequently. 

Thank you,
Bye,
Antonio.
