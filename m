Subject: Re: fstream on PPC?
From: Toni Van Remortel <t.vanremortel@ha.be>
Reply-To: t.vanremortel@ha.be
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <1069145908.1006.2.camel@toni>
References: <20031117155350.D76B7C5F59@atlas.denx.de>
	 <1069145908.1006.2.camel@toni>
Content-Type: text/plain
Message-Id: <1069148317.1006.8.camel@toni>
Mime-Version: 1.0
Date: Tue, 18 Nov 2003 10:38:38 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > > PS: don't mind the warning about libstdc++-libc6.2-2.so.3, it's in place
> > > on the embedded system.
> >
> > You must be joking. Of course you have to mind this.  It's  the  root
> > cause  of your problems. And other problems are lurking to hit you as
> > libstdc++-libc6.2-2.so.3 is most probably incompatible to  the  ELDK,
> > too.

I apologize for this stupid question: the symlink to the lib was wrong
inside the /opt/eldk/ppc_4xx/lib directory.

Anyhow, thanks for pointing me to the correct location of the problem, I
was seeking inside the FLTK map.

Regards,
--
                           Toni Van Remortel
              Wetenschappelijk Medewerker - D-science lab
  Real time Linux for embedded systems: http://linemb.d-sciencelab.com
              Tel: +32 3 205 61 72 - Fax: +32 3 205 61 95
                      E-mail: t.vanremortel@ha.be


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
