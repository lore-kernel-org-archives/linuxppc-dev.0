Message-ID: <B164B53F5BD6D511888D009027732E1A0249A6@ntserver.act.domain>
From: Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
To: "'Kent Borg'" <kentborg@borg.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: Abatron for Userland Debugging?
Date: Wed, 5 Dec 2001 09:27:52 +1100 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Why?

You only need Abatron in the cases where kernel crashes.
There is gdb for user applications.

You run gdbserver on the target and connect to it from another machine same
way as you would with abatron.

Rudolf

> -----Original Message-----
> From: Kent Borg [mailto:kentborg@borg.org]
> Sent: Wednesday, December 05, 2001 8:20 AM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: Abatron for Userland Debugging?
>
>
>
> I have used the Abatron to debug the kernel, but I am wondering
> whether it can easily be used to debug on the user side of the fence.
> Can it?  (If so, how?)
>
>
> Thanks,
>
> -kb
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
