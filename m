From: "Stefano Coluccini" <s.coluccini@caen.it>
To: "Zehetbauer Thomas" <TZ@link.topcall.co.at>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: booting HardHat on IBM 405GP
Date: Wed, 28 Mar 2001 10:05:24 +0200
Message-ID: <NDBBIFIMCKPOADMAJOKMOEJIDAAA.s.coluccini@caen.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <41EA756DBC9FD0118CFC0020AFDB5C5A188D96@tcint1ntsrv>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> It seems that execution stops when calling rfi in
> arch/ppc/kernel/head_4xx.S. I have put the sample code provided to
> output a single character on the serial port immediately before the rfi
> call and after the after the start_here label. Only the first is beeing
> executed. Any ideas?

Are you sure that the code that print a char on the serial port works also
with MMU enabled ?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
