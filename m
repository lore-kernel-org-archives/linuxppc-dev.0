Subject: EP405 network interface
From: Toni Van Remortel <t.vanremortel@ha.be>
Reply-To: t.vanremortel@ha.be
To: PPC Mailinglist <linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain
Message-Id: <1056636064.26546.6.camel@toni>
Mime-Version: 1.0
Date: 26 Jun 2003 16:01:05 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I cannot get the NIC working on my EP405. I used the ep405_config from
the linuxppc_2_4_devel tree.

This is a part of the output:

...
loop: loaded (max 8 devices)
eth0: No PHY device found.
removing net dev
...

So it seems that the kernel doesn't find the NIC (but it is there, and
working, ep-bootloader can use it to download the image).

Anybody an idea?

I already checked the NIC support, and the onboard-IBM NIC support is
enabled.

Regards,
--
                           Toni Van Remortel
              Wetenschappelijk Medewerker - D-science lab
                 Tel: 03 205 61 72 - Fax: 03 205 61 95
                      E-mail: t.vanremortel@ha.be


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
