From: "Ron Bianco" <ronb@junction.net>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: A stable linux 2.2.xx for sandpoint-8240 anywhere?
Date: Fri, 29 Dec 2000 11:26:39 -0800
Message-ID: <000501c071cd$44356c00$4d012ac7@warp-speed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

We've been working with the 2.3.16 port from MontaVista.
There are problems as this port was based on an experimental and unstable
kernel.
There are patches (tons) that fix some of the problems we've been seeing,
but we've come to the conclusion that it would be better to start with the
last 2.2.xx version and apply the sandpoint8240 and our changes to that.

So I was wondering if anyone knows of a 2.2.xx kernel with the sandpoint8240
changes already applied?
We're facing a deadline and must concentrate on a custom driver for now.

We've also considered the 2.4.xx-testxx kernels, but have deferred using
that until later when it is stable.

Eventually we'll make our patches for 8240 available.   Our target board is
custom, but might be useful to others doing a minimal 8240 system.

Ron Bianco
Computer Systems Technologist
Level Control Systems
email: ronb@junction.net
phone: 250-549-2558 Ext 8
web:  www.lcsaudio.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
