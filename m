Return-Path: <fvoegel@carangul.com>
Received: from asgard.akp-net.com (carangul.com [83.149.88.131])
	by ozlabs.org (Postfix) with ESMTP id 00964DDDDB
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Aug 2007 01:24:05 +1000 (EST)
Received: from port-87-234-84-178.dynamic.qsc.de ([87.234.84.178] helo=lumpi.x)
	by asgard.akp-net.com with esmtpa (Exim 4.62)
	(envelope-from <fvoegel@carangul.com>) id 1IGG3P-0005Ig-2E
	for linuxppc-embedded@ozlabs.org; Wed, 01 Aug 2007 17:24:03 +0200
Date: Wed, 1 Aug 2007 18:26:45 +0200
From: "Florian A. Voegel" <fvoegel@carangul.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: GPIO interrupts on mpc8313e
Message-Id: <20070801182645.b88ebeb1.fvoegel@carangul.com>
In-Reply-To: <2C4FDB8D627248AE9B24BC21747E0F5D.MAI@mail.livedns.co.il>
References: <2C4FDB8D627248AE9B24BC21747E0F5D.MAI@mail.livedns.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Is the interrupt configured properly for whatever it is you connect to it? (level vs edge triggered, rising vs falling)

Best regards,
Florian


On Wed, 1 Aug 2007 14:45:05 +0300
"Yoni Levin" <yoni.l@slyde-tech.com> wrote:

>  
> 
> I want to receive interrupt from 1 GPIO port (for example 14)
> 
> I changed the GPIMR to 0xffffffff (so I need to get interrupts from all GPIO
> ports)
> 
> And then request the irq by :
> 
> irq_create_mapping(NULL,74);
> 
> request_irq(74,handler,IRQF_DISABLED,"GPIO",NULL);
> 
> the return value is 0 (OK)
> 
> but I cant receive any interrupt.
> 
> do I need to do something else?
> 
>  
> 
>  
> 
> 
