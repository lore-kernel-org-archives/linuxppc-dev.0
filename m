Message-ID: <38733D74.93A9F24E@switchboard.ericsson.se>
Date: Wed, 05 Jan 2000 13:47:49 +0100
From: Kenneth Johansson <ken@kieraypc01.p.y.ki.era.ericsson.se>
Reply-To: ken@kieraypc01.p.y.ki.era.ericsson.se
MIME-Version: 1.0
To: Brendan.Simon@ctam.com.au
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dynamic binaries not working.
References: <38727B8B.2FBD0B8@ctam.com.au> <00010501374800.22517@enzo.bigblue.local> <3872D1EA.DF497905@ctam.com.au> <3872E8B5.F088FE57@fadata.bg> <3872ECED.6E46EBF6@ctam.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




Brendan J Simon wrote:

> Momchil 'Velco' Velikov wrote:
>
>
> I removed the -shared argument and the executable now looks a lot better interms of the vaddr and
> program headers etc.  I used "powerpc-linux-gcc -Wall -mcpu=860 -fpic -o bjs1 bjs1.c".  I tried
> with -fPIC, -fpic and without either.  The program still does not run however.  The output of
> objdump -p  is below.
> Does this look OK ?
> Any suggestions for debugging the code or the shared libraries ?
>

Have you patched your glibc source so it can work on 860 ??


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
