From: "Stephan Linke" <Stephan.Linke@epygi.de>
To: "Shen Rong" <rshen@udtech.com.cn>
Cc: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: debugging using BDI2000 on MPC860
Date: Mon, 16 Jun 2003 13:28:06 +0200
Message-ID: <FCEAKDJJAPHPLJFINDAJIEKCDCAA.Stephan.Linke@epygi.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <075c01c333f6$ce1c2bf0$e600a8c0@udtech.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Shen,

Thanks for your response,

I don't know how to interprete this but it always stops with the following status:

    Target state      : debug mode
    Debug entry cause : machine check interrupt
    Current PC        : 0x00000100
    Data  address     : 0x00000000
    DSISR value       : 0x00000000

Regards, Stephan

> -----Original Message-----
> From: Shen Rong [mailto:rshen@udtech.com.cn]
> Sent: Montag, 16. Juni 2003 13:03
> To: Stephan Linke
> Subject: Re: debugging using BDI2000 on MPC860
>
>
> Machine check exception vector is located at 0x200.
> 0x100 is reset vector, and it is ok.
>
> ----- Original Message -----
> From: "Stephan Linke" <Stephan.Linke@epygi.de>
> To: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
> Sent: Monday, June 16, 2003 6:56 PM
> Subject: debugging using BDI2000 on MPC860
>
>
> >
> > Hi,
> >
> > I want to use our BDI2000 to debug my MPC860 board. Unfortunately it always stops with a machine check interrupt at 0x00000100.
> > Flashing works fine.
> > Our flash is at 0xff000000, IMMR at f0000000...
> >
> > Any ideas? How do I define the boot address in MPC860 config files.
> >
> > Thanks, Stephan
> >
> >
> >
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
