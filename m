Message-ID: <20030415064244.30457.qmail@web41804.mail.yahoo.com>
Date: Mon, 14 Apr 2003 23:42:44 -0700 (PDT)
From: Cedric Aubert <cedric_aubert@yahoo.fr>
Reply-To: cedric_aubert@yahoo.fr
Subject: RE: uClibc Compiling problem
To: LinuxPPC Embedded <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Excuse me Wolfgang, you are right, I will more clear
in my question next
time !! :-)

Do you know why the file crtbeginS.o is search in the
directory

/opt/eldk/usr/lib/gcc-lib/ppc-linux/2.95.4/m860/pic/

instead of

/opt/eldk/ppc_8xx/usr/lib/gcc-lib/ppc-linux/2.95.4/

thanks

> In message
<20030414152233.13543.qmail@web41803.mail.yahoo.com>
you wrote:
> >
> > Does anyone known why the file crtbeginS.o is
absent
> > in the
> > ELDK 2.0.2 cross compiling tools (mpc860) ?
>
> If you installed the  ELDK  (at  least  the  ppc_8xx
 package)  under
> /opt/eldk, there should be a file
>
>
/opt/eldk/ppc_8xx/usr/lib/gcc-lib/ppc-linux/2.95.4/crtbeginS.o
>
> on your system. Please check again.
>
> Best regards,
>
> Wolfgang Denk


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
