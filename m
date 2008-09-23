Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id 3C78DDDE04
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 19:31:11 +1000 (EST)
Message-ID: <48D8B225.4000709@matrix-vision.de>
Date: Tue, 23 Sep 2008 11:08:53 +0200
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: Tjernlund <tjernlund@tjernlund.se>
Subject: Re: IRQ2-4 number to use on mpc83xx?
References: <062501c91d03$0c46be40$24d43ac0$@se>
In-Reply-To: <062501c91d03$0c46be40$24d43ac0$@se>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I can only tell how I do on MPC834x :

Table 8-6. IVEC/CVEC/MVEC Field Definition

Interrupt ID Number         Interrupt Meaning
17                                           IRQ1
18                                           IRQ2
19                                           IRQ3
20                                           IRQ4
21                                           IRQ5
22                                           IRQ6
23                                           IRQ7
48                                           IRQ0


Given this I can use this dts section for PCI devices connected @ IRQ0
and IRQ1

interrupt-map = <0x5800 0 0 1 &ipic 0x30 0x8
                                 0x6000 0 0 1 &ipic 0x11 0x8
                                 0x6000 0 0 2 &ipic 0x11 0x8>;

You should be able to use IRQ-Nr 18-20 for IRQ2-4.

regards,
Andre

Tjernlund schrieb:
> I am trying to figure out what IRQ number I should use for 
> external IRQ pins IRQ2-4. Can somebody please drop me a note
> on how the IRQ numbering works?
>
>     Jocke 
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>   


MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
