Message-ID: <B164B53F5BD6D511888D009027732E1A02498E@ntserver.act.domain>
From: Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
To: "'Dan Malek'" <dan@embeddededge.com>,
	Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: BDI2000 PTEs
Date: Wed, 28 Nov 2001 15:51:59 +1100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for reply, Dan

>
> Rudolf Ladyzhenskii wrote:
>
> > ..... At the moment I have memory translation enabled in BDI2000.
> > PTBASE is set to 0xf0 and this entry is cleared.
>
> That's not correct.

>
> > .... This works for kernel
> > debugging, but memory translation fails when I try to do
> dynamically loaded
> > module debugging.

All I need for kernel debugging is BAT only translation. I cleared it
according to BDI2000 manual.


> > I guess I have to set PTE pointers for BDI2000.
>
> No, you don't.  Just use a newer kernel that has this feature
> available for
> all processors.  You could also copy the couple of lines of
> code from a
> newer kernel into your 2.4.4 if you insist.
>
I looked at 2.4.14 kernel. It only has BDI2000 support in file
/arch/ppc/kernel/head_8xx.S
8260 uses different file. I searched that for traces of Abatron or BDI2000
without success.
I also downloaded ppc patch for 2.4.14. Same: no trace of "abatron" or
BDI2000 there.

Which lines do I have to add?

Thanks,
Rudolf

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
