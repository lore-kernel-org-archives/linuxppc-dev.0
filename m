Message-ID: <35C119252057D511BB9F0003476BF8A208E5C3@freexc01.smartm.com>
From: "Prasad, Siva" <Siva.Prasad@smartm.com>
To: "'Tom Rini'" <trini@kernel.crashing.org>,
	"Prasad, Siva" <Siva.Prasad@smartm.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: mtmsr...
Date: Wed, 26 Sep 2001 09:40:31 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


PowerPC 750 on a custom board.
I tried both the bitkeeper source (2.4.10-pre11) and also HartHat Linux CDK
1.2 version (kernel 2.2.14). Same problem in both the kernels.

I really appreciate any kind of help on this as I am clueless.

Thanks in advance.

-- Siva


> -----Original Message-----
> From: Tom Rini [mailto:trini@kernel.crashing.org]
> Sent: Tuesday, September 25, 2001 7:10 PM
> To: Prasad, Siva
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: mtmsr...
>
>
> On Tue, Sep 25, 2001 at 06:53:19PM -0700, Prasad, Siva wrote:
> >
>
> > My zImage hangs immediately after executing the 'mtmsr'
> instruction in the
> > arch/ppc/boot/head.S file.
> >
> > li    r3, 0
> > mtmsr r3
> > isync
> >
> > This is in the very beginning of the zImage, where it
> uncompresses the
> > actual image. Can some one help me out.
>
> What machine? What kernel?  From where?
>
> --
> Tom Rini (TR1265)
> http://gate.crashing.org/~trini/
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
