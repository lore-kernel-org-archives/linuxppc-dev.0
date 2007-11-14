Return-Path: <g.schardt@fz-juelich.de>
Received: from zam837.fz-juelich.de (zam837.fz-juelich.de [134.94.100.69])
	by ozlabs.org (Postfix) with SMTP id 98A18DDE02
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Nov 2007 03:36:33 +1100 (EST)
Date: Wed, 14 Nov 2007 17:36:31 +0100
From: g.schardt@fz-juelich.de
Subject: Re: Virtex TEMAC 1000Mb/s trouble, but 100b/s is working
To: alex_snippet <alex.snippet@gmail.com>
Message-id: <32948332c393.32c393329483@fz-juelich.de>
MIME-version: 1.0
Content-type: text/plain;
	charset=us-ascii
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

can you tell me, how to add this parameters to the kernel boot parameter ? or do you mount after booting ?

G



----- Original Message -----
From: alex_snippet <alex.snippet@gmail.com>
Date: Wednesday, November 14, 2007 4:44 pm
Subject: Re: Virtex TEMAC 1000Mb/s trouble, but 100b/s is working

> 
> Hi All
> 
> Thanks a lot
> 
> Trouble solved by adding tcp,no_lock !!!
> 
> Regards, Alex
> -- 
> View this message in context: http://www.nabble.com/Virtex-TEMAC-
> 1000Mb-s-trouble%2C-but-100b-s-is-working-tf4803823.html#a13749163
> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 



-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
Forschungszentrum Juelich GmbH
52425 Juelich

Sitz der Gesellschaft: Juelich
Eingetragen im Handelsregister des Amtsgerichts Dueren Nr. HR B 3498
Vorsitzende des Aufsichtsrats: MinDirig'in Baerbel Brumme-Bothe
Geschaeftsfuehrung: Prof. Dr. Achim Bachem (Vorsitzender), Dr. Ulrich Krafft (stellv. 
Vorsitzender)
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
