Message-ID: <001701c28a93$17910200$0200a8c0@telia.com>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Mark Hatle" <fray@mvista.com>
Cc: "Tom Rini" <trini@kernel.crashing.org>,
	"LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>,
	<alan@lxorguk.ukuu.org.uk>
References: <IGEFJKJNHJDCBKALBJLLAEPBFHAA.joakim.tjernlund@lumentis.se> <3DD15CFE.9060602@mvista.com>
Subject: Re: ppc_8xx-gcc 2.95.3 Monta Vista does not do ANY loop unrolling
Date: Tue, 12 Nov 2002 22:33:07 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> From one of our compiler guys in relationship to your original question:
>
>  > Later Alan Cox pointed out that my changes makes x86 run slower and it turns
>  > out that on x86 and a fairly new gcc will automatically unroll loops 'where
>  > appropriate'
>
> Fairly new: 3.3-pre only.

That's very new!
>
> Now I wonder:
>  > Is this a gcc 2.95.3, PPC or Monta Vista limitation?
>
> 2.95.3.
OK
>
>  > Which compiler will do unrolling 'where appropriate' for 8xx PPC and
>  > Where can I get a precompiled version?
>
> Nowhere, nor is using it for your kernels necessarily a good idea if
> you don't have compiler experience.
>
> > I know Dan is handling the enet stuff, but since you both work
>
> Dan no longer works for MontaVista.  (And has not for some time now.)
yes, my mistake.

Thanks for the info

        Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
