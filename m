Message-ID: <E69FF45ADA3BD511A25900047623CC4F12AA8D@JUPITER>
From: Neil Wilson <NWILSON@Airspan.com>
To: "'Dan Malek'" <dan@mvista.com>,
	James F Dougherty <jfd@GigabitNetworks.COM>
Cc: linuxppc-embedded@lists.linuxppc.org, cort@cs.nmt.edu
Subject: RE: ppc-linux EPIC (OpenPIC) and Interrupts on MPC8240
Date: Tue, 10 Jul 2001 08:34:10 +0100
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


If anyone has those patches are to hand I wouldn't mind them for my
Sandpoint X3 7450, thanks.

Neil

> -----Original Message-----
> From:	Dan Malek [SMTP:dan@mvista.com]
> Sent:	Monday, July 09, 2001 6:58 PM
> To:	James F Dougherty
> Cc:	linuxppc-embedded@lists.linuxppc.org; cort@cs.nmt.edu
> Subject:	Re: ppc-linux EPIC (OpenPIC) and Interrupts on MPC8240
>
>
> James F Dougherty wrote:
>
> > The board is essentially a Motorola Sandpoint design variant, so
> > I have started with the MontaVista Sandpoint port of linux-2.3.1
>
> What is linux-2.3.1?  Which version of the Sandpoint?
>
> If it is the old Sandpoint X2, and you are using the EPIC with
> discrete interrups (IRQ0 - IRQ4) the latest MontaVista HHL 2.0
> should be used (it should be used in any case).  The code in
> the public BK trees should also match this release.  If you are
> using a Sandpoint X3 with the serial mode interrupt EPIC, there
> are some patches I'll have to send you.
>
>
> 	-- Dan
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
