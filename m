From: =?iso-8859-1?Q?G=E9rard_Gu=E9vel?= <gguevel@interfaceconcept.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: IPV4 conformance and bit DF configuration
Date: Mon, 1 Mar 2004 12:22:51 +0100
Message-ID: <000001c3ff7f$947c00f0$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I work on a custom 8260 board with a 2.4.18 Linux kernel.

I have two questions  about IPV4.

Where can I found, if it exists, a list of conformance between the IPV4 and
the RFCxxx.

I want to set the DF (Don't Fragment bit) in an UDP socket without accessing
the IP header.
I don't find a setsockopt function to do it like for TOS or TTL.


Any ideas about that ?

Thanks all
Gérard Guével


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
