Message-ID: <20030603000005.28931.qmail@web21003.mail.yahoo.com>
Date: Mon, 2 Jun 2003 17:00:05 -0700 (PDT)
From: kas turi <inox_kas@yahoo.com>
Subject: dlopen causes the program to crash
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi
   I am running timesys linux 2.4.7-timesys-3.1.180 on
my 8260 board.  I have written a small program that
invokes dlopen and tries to access the shared library.
The program is linked with libdl-2.1.3.so.
The program is shown below:

#include <dlfcn.h>
#include <stdio.h>

main()
{
        void *handle;

        printf ("Before dlopen\n");
        handle = dlopen ("/lib/libpthread.so.0",
RTLD_NOW);
        printf ("dlopen done\n");

        dlclose(handle);
}

When I run on the target I get "Illegal instruction"
at dlopen even though libpthread.so.0 is present in
/lib directory.

Any idea why the dlopen causes the program to crash?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
