Message-ID: <B162270C965FD511AB9600B0D0B0AB420128241D@NAPA>
From: Mike Ji <hji@netscreen.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: va-ppc.h and powerpc-eabi-gcc
Date: Thu, 11 Jul 2002 15:59:05 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, folks,

I got in trouble with the "printf"...

* The cross-compiled I built is: powerpc-eabi-gcc.

* When I compile/build my codes, I also forced the compiler to use EABI by
"-meabi" usage.
* With "-v", I did see the default predefined Macro of "__PPC__" and
"CALLSYSV".

With those two macros, my codes will link the "va-ppc.h"(Please see the
stdarg.h).

The result is: my printf can't work properly when with complex input
parameters.

Would you guys give me some help if you happen to know this area?

Thanks a million,

Mike,


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
