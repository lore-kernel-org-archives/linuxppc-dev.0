Subject: RE: Doing floating point calculations in kernel space
From: Toni Van Remortel <t.vanremortel@ha.be>
Reply-To: t.vanremortel@ha.be
To: ARIBAUD Albert <a.aribaud@giat-industries.fr>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <F886A68DA978614991E47D82EA26B54210E987@csy-exchange1.giat.intra>
References: 
	 <F886A68DA978614991E47D82EA26B54210E987@csy-exchange1.giat.intra>
Content-Type: text/plain
Message-Id: <1066394252.1390.13.camel@toni>
Mime-Version: 1.0
Date: Fri, 17 Oct 2003 14:37:32 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > The CPU (405GP) has no FPU, but I need to calculate sin and cos in a
> > kernel module.
>
> Hmm... Bit off-topic, but why not use tables tailored to the
> precision you need (if you want to compute any sin or cas any time)
> or the equivalent of the Bresenham algorithm (if you only want to
> draw arcs or ellipes) ?

Currently, the floating point problem is solved. I'm not going to use
default sin and cos, because they are darn too slow.
Lookuptables are way to inaccurate for the application (the formula used
can be viewed at http://www.geniaal.be/), but I'll use other faster
formula's (found a PDF from a Playstation programmer :)

Tnx for the comment.
--
                           Toni Van Remortel
              Wetenschappelijk Medewerker - D-science lab
  Real time Linux for embedded systems: http://linemb.d-sciencelab.com
              Tel: +32 3 205 61 72 - Fax: +32 3 205 61 95
                      E-mail: t.vanremortel@ha.be


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
