Message-ID: <41058D7A.4080802@g-house.de>
Date: Tue, 27 Jul 2004 01:02:18 +0200
From: Christian Kujau <evil@g-house.de>
MIME-Version: 1.0
To: Giuliano Pochini <pochini@shiny.it>
Cc: LinuxPPC-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Can't compile 2.6.7 with gcc 3.4.1
References: <20040726223832.3edafe0a.pochini@shiny.it>
In-Reply-To: <20040726223832.3edafe0a.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Giuliano Pochini wrote:
> Is this a known problem ?  I can't compile the kernel 2.6.7 with gcc
3.4.1:
>
>   CC      arch/ppc/kernel/traps.o
> arch/ppc/kernel/traps.c: In function `AltivecUnavailException':
> arch/ppc/kernel/traps.c:650: warning: unsigned int format, long
unsigned int arg (arg 3)
> arch/ppc/kernel/traps.c: In function `AltivecAssistException':
> arch/ppc/kernel/traps.c:665: warning: implicit declaration of function
`emulate_altivec'
>   CC      arch/ppc/kernel/irq.o
>   CC      arch/ppc/kernel/idle.o
>   CC      arch/ppc/kernel/time.o
> {standard input}: Assembler messages:
- --------------------^^^^^^^^^

the Assembler spits out the errors here, and /usr/bin/as is usually
coming with "binutils". which version do you have?

Christian.
- --
BOFH excuse #72:

Satan did it

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
