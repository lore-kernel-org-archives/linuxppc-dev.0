Return-Path: <antonio.dibacco@aruba.it>
Received: from smtpa3.aruba.it (smtpa4.aruba.it [62.149.128.201])
	by ozlabs.org (Postfix) with SMTP id 2ACED679FB
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 May 2006 04:06:21 +1000 (EST)
From: Antonio Di Bacco <antonio.dibacco@aruba.it>
To: linuxppc-embedded@ozlabs.org
Subject: Re: HDLC synchronous
Date: Sun, 21 May 2006 20:06:20 +0200
References: <200605211925.49946.antonio.dibacco@aruba.it>
In-Reply-To: <200605211925.49946.antonio.dibacco@aruba.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605212006.20178.antonio.dibacco@aruba.it>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I 've understood well,  the hdlc_enet.c driver provided in denk kernel works 
if the hdlc controller can use cts and rts but my board has only INPUT, 
OUTPUT, CLK_INPUT and CLOCK_OUPUT pins. I imagine this is a synchronous 
interface, isn't it?

Bye,
Antonio.

On Sunday 21 May 2006 19:25, Antonio Di Bacco wrote:
> I had a look to hdlc_enet.c in 8xx_io and it seems to me that it only
> supports asynchronous HDLC (speaks about cts rts). Is this true?
>
> Bye,
> Antonio.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
