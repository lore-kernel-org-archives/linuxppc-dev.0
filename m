Date: Sat, 29 Jul 2000 18:02:31 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Olaf Hering <olh@suse.de>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: bogus dmasound.o module (was: Re: 2.4.0-test4 success (Re: affs))
In-Reply-To: <20000729164011.A11090@suse.de>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000729180037.1508C-100000@ofey.inetnebr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 29 Jul 2000, Olaf Hering wrote:

> Is PPC really defined? At least (sparc) is wrong and should be
> __sparc__. PPC should proably be __powerpc__.
> It is from current benh tree.

[dev@ofey tmp]$ cat t.c
#include <stdio.h>

int main()
{
#ifdef PPC
        printf("PPC is defined\n");
#else
        printf("PPC is not defined\n");
#endif
        return 0;
}
[dev@ofey tmp]$ gcc -o t t.c
[dev@ofey tmp]$ ./t
PPC is defined
[dev@ofey tmp]$ gcc -v
Reading specs from /usr/lib/gcc-lib/ppc-redhat-linux/2.95.2/specs
gcc version 2.95.2 19991024 (release/franzo)
[dev@ofey tmp]$


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
