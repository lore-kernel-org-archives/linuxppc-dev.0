Message-ID: <3BEF0066.88ACB438@mvista.com>
Date: Sun, 11 Nov 2001 14:49:10 -0800
From: Scott Anderson <scott_anderson@mvista.com>
MIME-Version: 1.0
To: Mark Pilon <mpilon@midrivers.com>
Cc: linuxppc-embedded@lists.linuxppc.org, jure@kom.org
Subject: Re: crash in atexit()
References: <3BEE9D33.F32035C3@midrivers.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark Pilon wrote:
> I'm SEGV'ing in atexit(), because of an apparently hard-coded
> null pointer dereference: [ the call to atexit() is made by
> __libc_start_main so I think I'm close to running ...]

This may be totally irrelevant, but I thought I would mention it just in
case it is useful.  At one point, I had to chase down a bug due to the
zero-page getting written to.  That bug was in early 405 kernels and was
due to a documentation defect in the 405GP documentation for the ZPR
register.  You might want to take a look and make sure that your
zero-page is still all zeroes.

    Scott Anderson
    scott_anderson@mvista.com   MontaVista Software Inc.
    (408)328-9214               1237 East Arques Ave.
    http://www.mvista.com       Sunnyvale, CA  94085

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
