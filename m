Date: Fri, 17 Oct 2003 14:16:58 +0200
From: ARIBAUD Albert <a.aribaud@giat-industries.fr>
Subject: RE: Doing floating point calculations in kernel space
To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Message-id: <F886A68DA978614991E47D82EA26B54210E987@csy-exchange1.giat.intra>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> -----Message d'origine-----
> De : owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]De la part de Toni
> Van Remortel
> Envoyé : vendredi 17 octobre 2003 09:16
> À : Linuxppc-Embedded
> Objet : Doing floating point calculations in kernel space
>
>
>
> Hi all,
>
> When I thought it was a /proc problem, it was a float problem.
> The CPU (405GP) has no FPU, but I need to calculate sin and cos in a
> kernel module.

Hmm... Bit off-topic, but why not use tables tailored to the
precision you need (if you want to compute any sin or cas any time)
or the equivalent of the Bresenham algorithm (if you only want to
draw arcs or ellipes) ?

HTH,

Albert.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
