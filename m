Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: bug: kernel timer added twice at e3259abc.
Date: Thu, 28 Mar 2002 19:47:16 -0500
References: <20020328040442.V26309@plato.local.lan> <Pine.GSO.4.21.0203281718540.4979-100000@vervain.sonytel.be> <20020328143117.X26309@plato.local.lan>
In-Reply-To: <20020328143117.X26309@plato.local.lan>
MIME-Version: 1.0
Message-Id: <20020329005501.GCSO11832.tomts24-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

The following has showed up in my dmesg log (running Ben's latest) on a
dual SMP G4 machine:

bug: kernel timer added twice at e3259abc.
bug: kernel timer added twice at e3259abc.

And using sun gem driver I see the following on occaision:

invalidate: busy buffer
sending pkt_too_big to self
sending pkt_too_big to self
sending pkt_too_big to self
sending pkt_too_big to self
sending pkt_too_big to self
sending pkt_too_big to self
sending pkt_too_big to self
sending pkt_too_big to self
sending pkt_too_big to self
sending pkt_too_big to self
sending pkt_too_big to self
Saw underflow (9728 of 61440 bytes). Treated as error
Saw underflow (3584 of 53248 bytes). Treated as error
sending pkt_too_big to self

Ideas welcome about either.

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
