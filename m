Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2A258687A1
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2005 14:26:14 +1100 (EST)
In-Reply-To: <17277.10875.334722.856865@cargo.ozlabs.ibm.com>
References: <1131357857.27347.28.camel@baythorne.infradead.org>
	<20051107160939.GD3839@smtp.west.cox.net>
	<1131380422.27347.72.camel@baythorne.infradead.org>
	<20051107165453.GA29111@lst.de>
	<1131382971.27347.79.camel@baythorne.infradead.org>
	<1132131116.28963.75.camel@baythorne.infradead.org>
	<17274.63508.501761.748278@cargo.ozlabs.ibm.com>
	<1132136755.21643.40.camel@hades.cambridge.redhat.com>
	<17277.10875.334722.856865@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3F990F6D-7A3F-47CA-938F-968593678895@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Thu, 17 Nov 2005 21:26:38 -0600
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Tom Rini <trini@kernel.crashing.org>, David Woodhouse <dwmw2@infradead.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] Fix 8250 probe on ppc32
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul or BenH,

Would you like to enlighten us on this ambitious rework?

- kumar

On Nov 17, 2005, at 7:12 PM, Paul Mackerras wrote:

> David Woodhouse writes:
>
>> I'll try it on Pegasos some time tonight or tomorrow. AFAICT I'm  
>> going
>> to need the patch which started this thread, if I want any serial  
>> ports
>> on my Pegasos. The newly-created asm-powerpc/serial.h file is  
>> devoid of
>> serial port definitions.
>
> This intersects with some more ambitious reworking Ben H is doing, so
> I won't put this one in.
>
> Paul.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
