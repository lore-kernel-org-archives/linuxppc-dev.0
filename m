Date: Mon, 13 Jan 2003 10:00:02 +0100
From: Peter Vandenabeele <peter.vandenabeele@mind.be>
To: Rudolf Ladyzhenskii <rudolf.ladyzhenskii@sdrct.com>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Virtex II Pro FPGA and Linux
Message-ID: <20030113100002.K7140@mind.be>
Reply-To: Peter Vandenabeele <peter.vandenabeele@mind.be>
References: <B164B53F5BD6D511888D009027732E1A4D14B6@ntserver.act.domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B164B53F5BD6D511888D009027732E1A4D14B6@ntserver.act.domain>; from rudolf.ladyzhenskii@sdrct.com on Mon, Jan 13, 2003 at 01:35:27PM +1100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jan 13, 2003 at 01:35:27PM +1100, Rudolf Ladyzhenskii wrote:
>
> Hi, all
>
> Did anyone tried to port ppcboot and/or Linux to those chips? (they containg
> up to 4 PPC cores).

Rudolf,

We have ported Linux to the Virtex II Pro last summer. We are currently
working to finish it on a particular standard board that holds a V2P4
(V2P with a single PowerPC 405), SRAM, SDRAM, Flash, Xilinx SDRAM
controller (soft core), Xilinx 10/100 Ethernet MAC (soft core), UART
(soft core), ... The board already boots Linux and we expect to publish
that code in a few weeks from now.

> Also any links regarding Linux and those FPGAs are appreciated. I am looking
> on including one of those in the new design and want to hear opinions.

It would be interesting to know which peripherals you require (in soft core
or hard core) to check which drivers are required. Did you start with a
certain V2P evaluation board, or still evaluating your options.

U-boot has initial support for the V2P. When we are ready with this port,
the support will be expanded for this board.

Peter

> Thanks,
>
> /************************/
> Rudolf Ladyzhenskii
> Senior Design Engineer
> SDR Communications Technologies
> ph.  +61 3 8080 8215
> fax. +61 3 9672 8800
> Level 9, 341 Queen Street,
> Melbourne, 3000
> Australia
> e-mail: rudolf.ladyzhenskii@sdrct.com
> /***********************/
>
>

--
.--------------------------------------------------------.
|       Mind: Embedded Linux and eCos Development        |
|--------------------------------------------------------|
| Peter Vandenabeele, CEO          email:  peter@mind.be |
| Mind ( http://mind.be )          tel:  +32-16-30.96.66 |
| Vaartkom 11                      fax:  +32-16-30.96.44 |
| B-3000 Leuven, Belgium           gsm: +32-478-27.40.69 |
'--------------------------------------------------------'

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
