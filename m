Message-ID: <35C119252057D511BB9F0003476BF8A208E5C4@freexc01.smartm.com>
From: "Prasad, Siva" <Siva.Prasad@smartm.com>
To: "'Tom Rini'" <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: mtmsr...
Date: Wed, 26 Sep 2001 15:46:55 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


'PowerBoot' is the firmware I am using.

I preferred to use 2.2.14 because, it has PowerCore option, where I can use
750  with minimal changes.

I am not making any calls to firmware after that. This 'mtmsr' instruction
is third instruction and it hangs with out finishing. What might be the
problem that I have to fix to get this working.

-- Siva


> -----Original Message-----
> From: Tom Rini [mailto:trini@kernel.crashing.org]
> Sent: Wednesday, September 26, 2001 3:43 PM
> To: Prasad, Siva
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: mtmsr...
>
>
> On Wed, Sep 26, 2001 at 09:40:31AM -0700, Prasad, Siva wrote:
>
> > PowerPC 750 on a custom board.
> > I tried both the bitkeeper source (2.4.10-pre11) and also
> HartHat Linux CDK
> > 1.2 version (kernel 2.2.14). Same problem in both the kernels.
>
> Well, both of those sources are very different.  Are you running this
> board in 'PReP' mode?  Your own firmware or what?  Anyhow, if
> you're making
> any calls back to the firmware later on, you must not mess w/
> the MSR value.
>
> --
> Tom Rini (TR1265)
> http://gate.crashing.org/~trini/
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
