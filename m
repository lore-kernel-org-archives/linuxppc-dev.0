MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: IPV4 conformance and bit DF configuration
Date: Thu, 4 Mar 2004 15:09:56 -0500
Message-ID: <AB5AF73EAF23304EA1B932174137CED70E709F@m5tmail.m5t.com>
From: "Jean-Denis Boyer" <jdboyer@m5t.com>
To: =?iso-8859-1?Q?G=E9rard_Gu=E9vel?= <gguevel@interfaceconcept.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Gérard,

> I want to set the DF (Don't Fragment bit) in an UDP socket
> without accessing
> the IP header.
> I don't find a setsockopt function to do it like for TOS or TTL.

There is a socket option for this: IP_PMTU_DISCOVER.
Have a look at the manual page ip(7).


Salutations,
--------------------------------------------
 Jean-Denis Boyer, Eng.
 M5T Centre d'Excellence en Télécoms Inc.
 4283 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-3972 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
