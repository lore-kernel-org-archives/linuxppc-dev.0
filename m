Message-ID: <3DD15CFE.9060602@mvista.com>
Date: Tue, 12 Nov 2002 13:56:46 -0600
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: joakim.tjernlund@lumentis.se
Cc: Tom Rini <trini@kernel.crashing.org>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>,
	alan@lxorguk.ukuu.org.uk
Subject: Re: ppc_8xx-gcc 2.95.3 Monta Vista does not do ANY loop unrolling
References: <IGEFJKJNHJDCBKALBJLLAEPBFHAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 From one of our compiler guys in relationship to your original question:

 > Later Alan Cox pointed out that my changes makes x86 run slower and it turns
 > out that on x86 and a fairly new gcc will automatically unroll loops 'where
 > appropriate'

Fairly new: 3.3-pre only.

Now I wonder:
 > Is this a gcc 2.95.3, PPC or Monta Vista limitation?

2.95.3.

 > Which compiler will do unrolling 'where appropriate' for 8xx PPC and
 > Where can I get a precompiled version?

Nowhere, nor is using it for your kernels necessarily a good idea if
you don't have compiler experience.

> I know Dan is handling the enet stuff, but since you both work

Dan no longer works for MontaVista.  (And has not for some time now.)

> for MV(don't you?) I figured you might know, being an insider and all :-)
>
> Maybe your tweak stuff could make use of forced unrolling?
>
>  Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
