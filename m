Message-ID: <638AA0336D7ED411928700D0B7B0D75BB32349@aimail.aiinet.com>
From: "Gessner, Matt" <mattg@aiinet.com>
To: "'Linux PPC'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Odd behaviour with 860P and LXT970
Date: Tue, 9 Oct 2001 16:23:37 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings,

We're using an 860P's FEC with an LXT970 PHY.
We're seeing something odd and would like to know
if anyone has either seen the same behaviour or
(hopefully) knows how to fix it.

We're using 2.2, but when I compare it to the 2.4
version, there are really no significant differences
(outside of things like 'struct device' vs. 'struct net_device').
In fact, what we're running is the same thing, just modified
to fit into 2.2.

The behaviour is that when we are connected to a hub
that can auto-negotiate speed and duplex and we change
the link speed (unplug off 100Mb/half and plug into 10Mb/half)
the link does not work.  We get the interrupts and the status
reads correctly, but we can't use the interface any longer.

If we unplug it from 100Mb/half and plug it back into the same
port it works just fine; likewise for 10Mb.  It's the switching
rates that causes the problem.

We appreciate any ideas.

Regards,

Matt Gessner


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
