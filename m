Subject: Controlling output pin
From: Toni Van Remortel <t.vanremortel@ha.be>
Reply-To: t.vanremortel@ha.be
To: linuxppc-embedded@lists.linuxppc.org
Content-Type: text/plain
Message-Id: <1064911115.17424.4.camel@toni>
Mime-Version: 1.0
Date: Tue, 30 Sep 2003 10:38:36 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I once found a small example somewhere which used an output pin of the
P1 connector of the EP405 board. It just outputted a square wave.
Now, I don't find it anymore, and I like to get it back, because it's
the perfect start for a kernel module I need to write.
Perhaps anybody else have another example on how to use an output
directly.

The target of my module:
* generate 2 PWM signals on 2 output pins.
* do this all in real time (with RTAI).

I rather start from an example, than start from scratch (because I never
dealt with direct pin control before).

So, if anybody van help me out with this, it's much appreciated.
--
                           Toni Van Remortel
              Wetenschappelijk Medewerker - D-science lab
  Real time Linux for embedded systems: http://linemb.d-sciencelab.com
              Tel: +32 3 205 61 72 - Fax: +32 3 205 61 95
                      E-mail: t.vanremortel@ha.be


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
