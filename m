Message-ID: <1081529851.4076d5fbd94a7@www.guy-smiley.com>
Date: Fri,  9 Apr 2004 12:57:31 -0400
From: Scott Stickeler <scott@guy-smiley.com>
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC8xx and wireless HERMES-II () ???
References: <40769D14.3030801@imc-berlin.de>
In-Reply-To: <40769D14.3030801@imc-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'd be very interested in what you find out. I am working on a project where I
want to do the exact same thing. I'll stay tuned :).

-Scott

Quoting Steven Scholz <steven.scholz@imc-berlin.de>:

>
> Hi there,
>
> I am trying to get a "proxim ORiNOCO PC Card" to work on my MPC8xx board
> with PCMCIA CS.
>
> Since it has a HERMES-II chipset I can't use the orinoco driver. So I went
> for Agere's wl_lkm_718_release.tar.gz.
>
> After inserting the card I get
>
> 	Wireless, HCF failure: "Command buffer size insufficient"
>
> :-(
>
> But funny enough I found the lines
>
> /*******************************************************************/
> /************************  Motorola Power PC 800 family  ***********/
> /*******************************************************************/
> /* known users: LH@I  */
> #if defined I_MPC8XX
> ...
>
> /*******************************************************************/
> /************************  MPC860  *********************************/
> /*******************************************************************/
> /* known users: RR */
>
> #if defined CPU
> #if CPU == PPC860
>
> in the include/hcf/hcfcfg.h. So of course now I wonder who might "LH@I" and
> "RR" be and if they realy use this driver in an MPC8xx environment.
>
> Any hints are mostly welcome !!!
>
> Thansk a million!
>
> --
> Steven Scholz
>
> imc Measurement & Control               imc Meßsysteme GmbH
> Voltastr. 5                             Voltastr. 5
> 13355 Berlin                            13355 Berlin
> Germany                                 Deutschland
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
