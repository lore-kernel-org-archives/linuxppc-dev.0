From: DavidHo@nanometrics.ca
In-Reply-To: <40631017.1020408@imc-berlin.de>
Subject: Re: IDE, PCMCIA and MAX_HWIFS... ?
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Message-ID: <OFEBEE1368.3E2B2AE5-ON85256E66.0050AA29-85256E66.00510BCB@nanometrics.ca>
Date: Mon, 29 Mar 2004 09:45:14 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steve,

I'm gonna try this on our board once it comes back from the shop.  Our
board is supposed to have a CompactFlash card and a IDE disk attached.  The
current prototype board has a small problem that kept me from testing them
together.

It will be interesting.

David Ho
Nanmetrics Inc.

owner-linuxppc-embedded@lists.linuxppc.org wrote on 03/25/2004 12:00:07 PM:

>
> Hi there,
>
> if I have one IDE interface on my embedded PPC board and I might use a PC
> Card HDD in the PCMCIA socket, then do I have to override the define
> MAX_HWIFS with 1 or 2 ?
>
> So do I need some kind of a place holder for the IDE interface that might
> appear via PCMCIA Card service?
>
> Thanks a million.
>
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


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
