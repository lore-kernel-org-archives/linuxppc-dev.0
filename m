Subject: Re: /proc problem
From: Toni Van Remortel <t.vanremortel@ha.be>
Reply-To: t.vanremortel@ha.be
To: "Guy M. Streeter" <streeter@redhat.com>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <1066313452.1033.1.camel@jarjar.hsv.redhat.com>
References: <1066306828.735.29.camel@toni>
	 <1066313452.1033.1.camel@jarjar.hsv.redhat.com>
Content-Type: text/plain
Message-Id: <1066314292.735.32.camel@toni>
Mime-Version: 1.0
Date: Thu, 16 Oct 2003 16:24:53 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


[unresolved symbol __extendsfdf2]

Op do 16-10-2003, om 16:10 schreef Guy M. Streeter:
> You're trying to do floating-point math. The kernel doesn't do
> floating-point.

Hmm. Is there a work-around? Because the control interface (written with
FLTK) does use floating points and works.

--
                           Toni Van Remortel
              Wetenschappelijk Medewerker - D-science lab
  Real time Linux for embedded systems: http://linemb.d-sciencelab.com
              Tel: +32 3 205 61 72 - Fax: +32 3 205 61 95
                      E-mail: t.vanremortel@ha.be


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
