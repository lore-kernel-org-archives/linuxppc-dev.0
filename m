Message-ID: <41EA756DBC9FD0118CFC0020AFDB5C5A188D97@tcint1ntsrv>
From: Zehetbauer Thomas <TZ@link.topcall.co.at>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: booting HardHat on IBM 405GP
Date: Wed, 28 Mar 2001 13:17:30 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am not certain but I have tried to enable MSR_DR and was still able to
print to the serial console.

Tom

> -----Original Message-----
> From: Stefano Coluccini [mailto:s.coluccini@caen.it]
> Sent: Wednesday, March 28, 2001 10:05 AM
> To: Zehetbauer Thomas
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: RE: booting HardHat on IBM 405GP
>
>
>
> > It seems that execution stops when calling rfi in
> > arch/ppc/kernel/head_4xx.S. I have put the sample code provided to
> > output a single character on the serial port immediately
> before the rfi
> > call and after the after the start_here label. Only the
> first is beeing
> > executed. Any ideas?
>
> Are you sure that the code that print a char on the serial
> port works also
> with MMU enabled ?
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
