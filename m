Subject: RE: Doing floating point calculations in kernel space
From: Toni Van Remortel <t.vanremortel@ha.be>
Reply-To: t.vanremortel@ha.be
To: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <1066377138.735.48.camel@toni>
References: <3F710B1D00088333@mssbzhh-int.msg.bluewin.ch>
	 <1066377138.735.48.camel@toni>
Content-Type: text/plain
Message-Id: <1066381142.735.75.camel@toni>
Mime-Version: 1.0
Date: Fri, 17 Oct 2003 10:59:29 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Op vr 17-10-2003, om 09:52 schreef Toni Van Remortel:
> Op vr 17-10-2003, om 09:33 schreef Wolfgang Grandegger:
> >  ftp://ftp.denx.de/pub/RTAI/contrib/fp_ppc_8xx.tar.bz2
> > It links statically with the libm and the soft-float
> > library derived from libgcc.
> >
> > Hope it's useful.
>
> Seems useful. Let's check it out deeper and implement it into my module.
> I'll keep you informed.

It compiles, it runs. Very nice. Thank you a lot for the example. I had
only to add the extra linking to my compile command.

Regards,

--
                           Toni Van Remortel
              Wetenschappelijk Medewerker - D-science lab
  Real time Linux for embedded systems: http://linemb.d-sciencelab.com
              Tel: +32 3 205 61 72 - Fax: +32 3 205 61 95
                      E-mail: t.vanremortel@ha.be


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
