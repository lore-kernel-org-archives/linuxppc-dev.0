Message-ID: <3E9617D4.40EB5B63@bmrtech.com>
Date: Fri, 11 Apr 2003 09:18:13 +0800
From: Jikun Sun <jack.sun@bmrtech.com>
MIME-Version: 1.0
To: Dan Kegel <dank@kegel.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux crash when big application executing on PPC405GP board
References: <3E95E275.1050002@kegel.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> jack.sun@bmrtech.com wrote:
> > Board: CSB272 IBM PPC405GP
> > Linux kernel version: 2.4.17
> > Linux kernel can boot nfs root filesystem on the board. Shell works
> > correctly.
> > However the system will oops when execute big applications, such as
> > copying a file which is larger than 2MBytes.
> > The following is ksymoops:
> >
> > The size of vmlinux.srec is 2.076Mbytes.
> > root@192.9.200.145:/# cp vmlinux.srec vmlinux.srec.bak
> >
> > Oops: kernel access of bad area, sig: 11
>
> Where did you get your kernel?

MontaVista

>
> What compiler did you use to build it?

ppc_405-gcc


Jikun


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
