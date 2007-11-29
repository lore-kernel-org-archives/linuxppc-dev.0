Return-Path: <g.schardt@fz-juelich.de>
Received: from zam837.fz-juelich.de (zam837.fz-juelich.de [134.94.100.69])
	by ozlabs.org (Postfix) with SMTP id B9A7FDDDFB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Nov 2007 23:53:04 +1100 (EST)
Message-ID: <474EB62D.9000908@fz-juelich.de>
Date: Thu, 29 Nov 2007 13:53:01 +0100
From: schardt <g.schardt@fz-juelich.de>
MIME-Version: 1.0
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: Init hangs on Xilinx4
References: <474D8839.6020609@fz-juelich.de> <474EB36D.1080408@dlasys.net>
In-Reply-To: <474EB36D.1080408@dlasys.net>
Content-Type: text/plain;
	charset=ISO-8859-1
Cc: Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


David H. Lynch Jr. wrote:
> I had a similar problem. In my instance it turned out that I was
> inadvertently using the physical address of my uart as the output address.
> This worked during boot becasue there was a 1:1 physical-logical entry
> stuffed into the MMU. But since Linux did nto know about it, as soon as
> the VM system decided to use that TLB entry IO died - right in the
> middle of a string.
>
> While it is unlikely you made exactly the same mistake. One area you can
> check is memory.
>
> What is your output device ?
>
>   
My Output Device is a Xilinx UartLite at 0x40600000 and the kernel
detects this
as /dev/ttyUL0.

Georg







-------------------------------------------------------------------
-------------------------------------------------------------------
Forschungszentrum Jülich GmbH
52425 Jülich

Sitz der Gesellschaft: Jülich
Eingetragen im Handelsregister des Amtsgerichts Düren Nr. HR B 3498
Vorsitzende des Aufsichtsrats: MinDirig'in Bärbel Brumme-Bothe
Geschäftsführung: Prof. Dr. Achim Bachem (Vorsitzender),
Dr. Ulrich Krafft (stellv. Vorsitzender), Dr. Sebastian M. Schmidt
-------------------------------------------------------------------
-------------------------------------------------------------------
