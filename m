Message-ID: <3873C4A3.72079612@ctam.com.au>
Date: Thu, 06 Jan 2000 09:24:36 +1100
From: Brendan J Simon <Brendan.Simon@ctam.com.au>
Reply-To: Brendan.Simon@ctam.com.au
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC860 patches for glibc
References: <38727B8B.2FBD0B8@ctam.com.au> <00010501374800.22517@enzo.bigblue.local> <3872D1EA.DF497905@ctam.com.au> <3872E8B5.F088FE57@fadata.bg> <3872ECED.6E46EBF6@ctam.com.au> <38733D74.93A9F24E@switchboard.ericsson.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kenneth Johansson wrote:

> Brendan J Simon wrote:
>
> > Momchil 'Velco' Velikov wrote:
> >
> >
> > I removed the -shared argument and the executable now looks a lot better interms of the vaddr and
> > program headers etc.  I used "powerpc-linux-gcc -Wall -mcpu=860 -fpic -o bjs1 bjs1.c".  I tried
> > with -fPIC, -fpic and without either.  The program still does not run however.  The output of
> > objdump -p  is below.
> > Does this look OK ?
> > Any suggestions for debugging the code or the shared libraries ?
> >
>
> Have you patched your glibc source so it can work on 860 ??

I didn't realise there were 860 patches for glibc.
Where can I get these patches from ?
What do they do ?

I just ran configure and make with CC="powerpc-linux-gcc -mcpu=860" or CFLAGS=-mcpu=860.  I can't
remember which.

Thanks,
Brendan Simon.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
