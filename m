Subject: RE: Doing floating point calculations in kernel space
From: Toni Van Remortel <t.vanremortel@ha.be>
Reply-To: t.vanremortel@ha.be
To: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <3F710B1D00088333@mssbzhh-int.msg.bluewin.ch>
References: <3F710B1D00088333@mssbzhh-int.msg.bluewin.ch>
Content-Type: text/plain
Message-Id: <1066377138.735.48.camel@toni>
Mime-Version: 1.0
Date: Fri, 17 Oct 2003 09:52:19 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Op vr 17-10-2003, om 09:33 schreef Wolfgang Grandegger:
> Hi,
>
> this has been discussed recently. For RTAI on MPC 8xx we
> provide the following example:
>
>  ftp://ftp.denx.de/pub/RTAI/contrib/fp_ppc_8xx.tar.bz2
>
> It links statically with the libm and the soft-float
> library derived from libgcc.
>
> Hope it's useful.

Seems useful. Let's check it out deeper and implement it into my module.

I'll keep you informed.

Tnx!
--
                           Toni Van Remortel
              Wetenschappelijk Medewerker - D-science lab
  Real time Linux for embedded systems: http://linemb.d-sciencelab.com
              Tel: +32 3 205 61 72 - Fax: +32 3 205 61 95
                      E-mail: t.vanremortel@ha.be


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
