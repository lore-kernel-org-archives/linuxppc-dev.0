Subject: /proc problem
From: Toni Van Remortel <t.vanremortel@ha.be>
Reply-To: t.vanremortel@ha.be
To: linuxppc-embedded@lists.linuxppc.org
Content-Type: text/plain
Message-Id: <1066306828.735.29.camel@toni>
Mime-Version: 1.0
Date: Thu, 16 Oct 2003 14:20:29 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I just added some /proc support to my module to run on an EP405, but
when I load my module, I get
unresolved symbol __extendsfdf2
Google didn't get me any further.
Code can be found at http://linemb.d-sciencelab.com/rt_mod.c

Thanks,
--
                           Toni Van Remortel
              Wetenschappelijk Medewerker - D-science lab
  Real time Linux for embedded systems: http://linemb.d-sciencelab.com
              Tel: +32 3 205 61 72 - Fax: +32 3 205 61 95
                      E-mail: t.vanremortel@ha.be


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
