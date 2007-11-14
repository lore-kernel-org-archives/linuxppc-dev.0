Return-Path: <g.schardt@fz-juelich.de>
Received: from zam837.fz-juelich.de (zam837.fz-juelich.de [134.94.100.69])
	by ozlabs.org (Postfix) with SMTP id BD576DDDD6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Nov 2007 04:01:50 +1100 (EST)
Date: Wed, 14 Nov 2007 18:01:49 +0100
From: g.schardt@fz-juelich.de
Subject: Re: Virtex TEMAC 1000Mb/s trouble, but 100b/s is working
To: jozsef imrek <imrek@atomki.hu>
Message-id: <32cbb532c64c.32c64c32cbb5@fz-juelich.de>
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

argl, i read the nfsroot.txt but imho i am a little bit blind :)

thanks
G

----- Original Message -----
From: jozsef imrek <imrek@atomki.hu>
Date: Wednesday, November 14, 2007 6:00 pm
Subject: Re: Virtex TEMAC 1000Mb/s trouble, but 100b/s is working

> On Wed, 14 Nov 2007 g.schardt@fz-juelich.de wrote:
> 
> >>
> >> Trouble solved by adding tcp,no_lock !!!
> >>
> >
> > can you tell me, how to add this parameters to the kernel boot 
> parameter ? or do you mount after booting ?
> >
> 
> if you are using a bootloader see Documentation/nfsroot.txt in the 
> linuxsource tree (a quick example: 
> nfsroot=192.168.0.1:/nfsroot,tcp,no_lock).
> if you are using dhcp, then you have to tell your dhcp server to 
> serv 
> these paramters (for the isc dhcpd: option root-path 
> "/nfsroot,tcp,no_lock").
> -- 
> mazsi
> 
> ----------------------------------------------------------------
> strawberry fields forever!                       imrek@atomki.hu
> ----------------------------------------------------------------
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
