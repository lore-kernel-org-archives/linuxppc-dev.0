Message-ID: <3A8974B8.D197FEC9@mvista.com>
Date: Tue, 13 Feb 2001 09:54:00 -0800
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Grant Erickson <erick205@umn.edu>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Patch for Soft-Float Problems w/ Glibc & Gcc?
References: <Pine.SOL.4.20.0102131051470.8375-100000@garnet.tc.umn.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Grant Erickson wrote:
>
> For some time I've noted but have never bothered chasing down the *printf
> problems associated with using -msoft-float/-D_SOFT_FLOAT on Linux/PPC.
>
> Needing to remedy the issue, I started chasing it down using the code
> samples below. When compiled using just '$(CROSS_COMPILE)gcc -o pi-test
> *.c' everything works fine:
>
> ...

I believe we fixed this problem around CDK 1.2 time.  Unfortunatly I
don't remember what we did to fix the problem.  I am almost sure it has
to do with the spec file for gcc.  (not rpm spec, but the
...lib/gcc-lib/2.95.2/spec.

Give the CDK 1.2 compiler a try on that code and see if it fixes the
problem you are having.  (Keep in mind that you will also need to use
the glibc provided.  The floating point printf fix effects both glibc
and gcc.)

ftp://ftp.mvista.com/pub/CDK/1.2

If that does fix your problem I can help you track down the patch that
does the fix.  (It's been 6 or so months since I made these patches so
my memory is a bit fuzzy right now.)

--Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
