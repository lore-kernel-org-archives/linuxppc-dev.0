Date: Wed, 22 Aug 2001 03:25:09 -0700
From: Matt Porter <mporter@mvista.com>
To: Ole Andreas Torvmark <ole.torvmark@radionor.no>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problems with Sandpoint 8240 & i82559 & i82550
Message-ID: <20010822032509.A32016@cx258813-a.chnd1.az.home.com>
References: <MHEAIGEFFBAFIOMKCIGCMEAICAAA.ole.torvmark@radionor.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <MHEAIGEFFBAFIOMKCIGCMEAICAAA.ole.torvmark@radionor.no>; from ole.torvmark@radionor.no on Wed, Aug 22, 2001 at 12:56:54PM +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Aug 22, 2001 at 12:56:54PM +0200, Ole Andreas Torvmark wrote:
>
> During boot the board comes to this point :

<snip>

> eepro100.c:v1.09j-t 9/29/99 Donald Becker
> http://cesdis.gsfc.nasa.gov/linux/drive
> rs/eepro100.html
> eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
> <saw@sa
> w.sw.com.sg> and others
> eth0: PCI device 8086:1229, 00:02:B3:60:8F:9F, IRQ 16.
>   Board assembly 751767-004, Physical connectors present: RJ45
>   Primary interface chip i82555 PHY #1.
>     Secondary interface chip i82555.
> Self test failed, status ffffffff:
>  Failure to initialize the i82557.
>  Verify that the card is a bus-master capable slot.

When the self test fails on an i8255x device it indicates a
problem with inbound transations to system memory.  Obviously
outbound transactions are working since it's reading the MAC
address from the EEPROM.

> First off the problem seems to be that the self test fails.  And then i get
> the wait_for_cm_done timeout! message. I have tried two different intel
> cards the one is i82550 based and the other is older and based on the i82559
> chip. We have a Linux server here running 2.4.8 and it has the exactly same
> driver and it does not fail so I think it is something with the Sandpoint
> Reference Platform.

You neglected to give us basic information on what kernel tree
you are running.  We need that in order to have a chance to
help you.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
