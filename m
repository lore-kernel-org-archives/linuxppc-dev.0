MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Problems of kernel-2.6.4 for mpc8260
Date: Wed, 7 Apr 2004 10:40:37 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B06DAB2@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "linuxppc" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You need a newer version of modutils

Try module-init-tools-3.0.tar.gz from
http://www.kernel.org/pub/linux/kernel/people/rusty/modules/

This fixed that problem for me on 2.6.3 and 2.6.5 on a 8266. The other
version is known not to work with the new module initialization stuff in
the 2.6 kernels.

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org] On Behalf
> Of Wolfgang Grandegger
> Sent: Wednesday, April 07, 2004 08:26
> To: ???
> Cc: linuxppc
> Subject: Re: Problems of kernel-2.6.4 for mpc8260
>
>
>
> On 04/07/2004 09:51 AM ??? wrote:
> > I got succeeded to port kernel 2.6.4 to out custom MPC8260
> board with
> > the help of DENX ELDK 3.0 tool. Thanks!! But there is some
> problems to
> > be solved.
> >
> > After booting, when I try to install module, following
> error occured.
> >
> >       bash-2.05b# insmod dsrc_drv.o
> >       insmod: QM_MODULES: Function not implemented
>
> Module support seems not to be enabled in your kernel.
>
> >
> >       bash-2.05b# insmod -V
> >       insmod version 2.4.22
> >
> > As you can see above, the version of modutils seems to be
> fine. right?
> > If so, what's the reason of above error? And one more
> problem. At boot
> > sequence(as following) lots of unexpected 'modprobe: xxx'
> messages are
> > issued.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
