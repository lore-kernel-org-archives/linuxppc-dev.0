Date: Fri, 03 Oct 2003 09:57:50 +0200
From: ARIBAUD Albert <a.aribaud@giat-industries.fr>
Subject: RE: Queston about Walnut
To: linuxppc-embedded@lists.linuxppc.org
Message-id: <F886A68DA978614991E47D82EA26B542131C76@csy-exchange1.giat.intra>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


(disclaimer : I work on 8xx, not 4xx)

I would suggest inspecting the timings for memory access.
If this is SDRAM, you must have had to program the UPM for
it, I suppose. Might be that VxWorks has it right, and you
have set it up differently.

Also, writing to address 0 might be a Bad Ideam (tm), if you
have set this area to hold interrupt vectors.

Did you try single write (say, "mw 100000 0") ?

Albert.

P.S. I think that if you write directly to linuxppc-embedded,
Wolfgang will cease receiving you mails twice (which he probably
does now since you e-mail him *and* CC: to the list).

> -----Message d'origine-----
> De : owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]De la part de Jacky
> Lam
> Envoyé : vendredi 3 octobre 2003 06:11
> À : Wolfgang Denk
> Cc : linuxppc-embedded@lists.linuxppc.org
> Objet : Re: Queston about Walnut

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
