Message-ID: <000b01c45534$8542bba0$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Andrew Dennison" <andrew.dennison@motec.com.au>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <002601c454f4$13e589a0$ee00a8c0@CAT>
Subject: Re: JTAG debuggers for Motorola 8xx/82xx/85xx 
Date: Fri, 18 Jun 2004 09:02:30 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Andrew,

I went down this same path!  No, the 5200 JTAG is quite different from 8xx
and a little different from 8xxx so no version of the Wiggler will work,
although Macraigor says they are planning to support 5200 soon.

When I was evaluating the 5200Lite I used the Motorola boot to load
zImage.elf, and that let me play with linux.

I hope Greenhills and Metrowerks are listening - their debuggers are
unusable in IMHO.  As a hardware designer I'm typically the guy who
recommends a debugger to the programmers, so if they don't have a tool that
lets you poke around without a whole project structure, they're not going to
get my vote.

So, another win for BDI, I guess.

Mark Chambers

----- Original Message -----
From: "Andrew Dennison" <andrew.dennison@motec.com.au>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Friday, June 18, 2004 1:21 AM
Subject: RE: JTAG debuggers for Motorola 8xx/82xx/85xx


>
> > Wolfgang wrote:
> >
> > Note that the GDB in our ELDK not only supports the BDM4GDB, but also
> > the wiggler ...
> >
>
> So I could use a wiggler and GDB from ELDK with MPC5200?
>
> I've been asked to try to avoid buying a BDI2000 for now :(
>
> I already have the Greenhills slingshot and Metrowerks Wiretap from the
> 5200lite kit but they seem to be paper weights without their (expensive)
> integrated software tools...
>
> Andrew
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
