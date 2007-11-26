Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8BF46DDE22
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 02:41:15 +1100 (EST)
Message-Id: <CAF0919C-0116-403C-A8C5-024B43480D77@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200711252322.09370.arnd@arndb.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 1/3] [POWERPC] Add docs for Freescale 83xx SATA device
	tree nodes
Date: Mon, 26 Nov 2007 09:41:07 -0600
References: <Pine.LNX.4.64.0711202310280.24220@blarg.am.freescale.net>
	<Pine.LNX.4.64.0711202312130.24220@blarg.am.freescale.net>
	<200711252322.09370.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 25, 2007, at 4:22 PM, Arnd Bergmann wrote:

> On Wednesday 21 November 2007, Kumar Gala wrote:
>> +    * Freescale 8xxx/3.0 Gb/s SATA nodes
>> +
>> +    SATA nodes are defined to describe on-chip Serial ATA  
>> controllers.
>> +    Each SATA port should have its own node.
>> +
>> +    Required properties:
>> +    - compatible        : compatible list, contains 2 entries,  
>> first is
>> +                        "fsl,sata-CHIP", where CHIP is the processor
>> +                        (mpc8315, mpc8379, etc.) and the second is
>> +                        "fsl,sata-pq2pro"
>> +    - interrupts        : <interrupt mapping for SATA IRQ>
>> +    - interrupt-parent  : optional, if needed for interrupt mapping
>> +    - reg               : <registers mapping>
>> +
>
> Should this maybe also mandate a compatible property that is defined
> in a way to match the generic (p)ata_of_platform driver?

Is there something about the (p)ata_of_platform driver you think we  
can use.  The SATA controller here is a unique piece of HW and  
requires a unique driver so I'm not sure what we get from  
(p)ata_of_platform.

- k
