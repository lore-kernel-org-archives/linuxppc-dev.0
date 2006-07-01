Return-Path: <white@from-b.org>
Received: from aphrodite.net-build.de (aphrodite.net-build.de [212.88.135.60])
	by ozlabs.org (Postfix) with ESMTP id 94FBA679FF
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Jul 2006 19:03:07 +1000 (EST)
Date: Sat, 1 Jul 2006 10:53:37 +0200
From: White <white@from-b.org>
To: linuxppc-embedded@ozlabs.org
Subject: Re: rs232 endianness on PPC
Message-ID: <20060701105337.3fcd5f0f@White64>
In-Reply-To: <13853799.1151694631780.JavaMail.root@ps13>
References: <13853799.1151694631780.JavaMail.root@ps13>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "tauanna@tiscali.it" <tauanna@tiscali.it>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


PowerPC is only Byte swaped, not bit-swaped :)
(I thought there are only some old mainly unused Architecturs, who swap
the Bits :)

The second: I think the bitorder on the rs232 is standarized :) and
should be the same ... :)

Am Fri, 30 Jun 2006 21:10:31 +0200 (CEST) schrieb "tauanna@tiscali.it"
<tauanna@tiscali.it> :

> Hi,
> 
> when I write a byte on the SMC1 (MPC875) serial device (let us say 
> 0x11) what should I expect on the output pin? First a 0 then 0, 0, 1, 
> 0, 0, 0, 1 or the opposite. Is it different on a little endian CPU?
> 
> Bye,
> Antonio.
> 
> 
> 
> 
> 		
> Hai voglia di fare un viaggio, ma non sai dove andare?
> Scegli una delle nostre offerte HOTEL IN ITALIA E IN EUROPA da 50 euro.
> Prenota subito su Expedia.it e... buona vacanza!
> 
> http://expedia.viaggi.tiscali.it/default.aspx?eapid=330-8 
>  
> 	
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
