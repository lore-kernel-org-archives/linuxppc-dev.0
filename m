Message-ID: <BE1C564723B3D21191FD0000F840E39801D81568@rfcmx2.rfc.comm.harris.com>
From: "Brown, David (dbrown03)" <DBrown03@harris.com>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: SMC2
Date: Wed, 7 Jun 2000 13:40:41 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Bright Star's ipEngine, using an 823, has SMC1 and SMC2 also.
When used with their pKernel, both serial ports are available.
When used with Linux, only SMC1 is available.
I noticed it, and thought it might be easy to fix, but
that's not important to me, since I only use the ipEngine for prototyping.
--
Dave Brown <dbrown03@harris.com>
Principal Engineer, Software
Harris Corporation RFCD

> -----Original Message-----
> From: Dan Malek [mailto:dan@netx4.com]
> Sent: Wednesday, June 07, 2000 1:05 PM
> To: Grant Carter
> Cc: linuxppc-embedded
> Subject: Re: SMC2
>
>
>
> Grant Carter wrote:
>
> > When I look at my manuals, I see no reference made to the
> bits 20 and 21
> > in pbpar, pbdir or pbodr. How does setting those bits
> enable the SMC2
> > pins? Those are located in Port A (PA8 and PA9)
> >
> > I guess my point is why are the Port B registers being
> modified for SMC2
> > pins which are found in Port A?
>
> Oh oh......are you using an 823 or 850?  Sorry about this, you will
> have to change the code.  Someday, I have to finish up a better UART
> driver.  You are the first person I know that is trying to use this
> as a UART.  SMC2 is the first thing to disappear when using the parts
> for other data communication protocols or interfaces, so custom
> software tends to assign these for other purposes.  I seldom
> see anything
> but SMC1 used for a UART, so making the driver better hasn't been
> high on the list......
>
>
> 	-- Dan
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
