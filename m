Message-ID: <7283DE19D141D111AD0E00A0C95B195502581F18@mail2.aiinet.com>
From: "Gessner, Matt" <mattg@aiinet.com>
To: "'Srinivas Rao.M'" <msrao@vxl.co.in>
Cc: "'Linux PPC'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: PowerPC assembly
Date: Thu, 29 Mar 2001 08:36:37 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Check out the objdump utility that goes along with your compiler.
I'm assuming you're using a gcc-like compiler suite (cygwin maybe).

HTH

Matt

> -----Original Message-----
> From: Srinivas Rao.M [mailto:msrao@vxl.co.in]
> Sent: Wednesday, March 28, 2001 11:17 PM
> To: Madhuri Jones
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: PowerPC assembly
>
>
>
> Hi,
>  Is there any utility to dis assemble the .o file (something like dis
> available in sco) that can run on WindowsNT. I have a cross
> development
> platform WinNT. I am compiling code form MPC860. I just want
> to know if i
> can dis assemble a .o file.
>
> -srini...
>
> On Wed, 28 Mar 2001, Madhuri Jones wrote:
>
> >
> > Hello,
> >
> > I am novice in Power PC assembly code and I am trying
> > compile in following code (written by someone else)  into
> head_8xx.S.
> >
> > This function has instruction like
> >
> > mfspr r3, IC_CST
> > LA r4, IC_CST_LEN
> >
> > However the hardhat assembler doesn't understand the
> mnemonic LA, is LA same
> > as add immediate instruction?
> > addi r4, r4, IC_CST_LEN
> >
> > Please help!!
> >
> > Thanks.
> >
> > M.J.
> >
> >
>
> --
>
> We are responsible for what we are, and whatever we wish
> ourselves to be, we
> have the power to make ourselves. If what we are now has been
> the result of
> our own past actions, it certainly follows that whatever we
> wish to be in
> future can be produced by our present actions; so we have to
> know how to act.
> -Swami Vivekananda
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
