Date: Mon, 29 Oct 2001 17:35:39 +0100
From: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
Subject: linuxppc_2_4_devel on walnut
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Cc: akuster@mvista.com
Message-id: <3BDD855B.8D3FC72F@inn.ericsson.se>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I tried the latest version on my walnut card and noticed two things.

1. The default configuration don't compile

2. The ethernet driver gets confused. It reports 10mb and half duplex when it
really is 100Mb full duplex. And it reports 100Mb full duplex when only 10Mb
half duplex exist.


--
Kenneth Johansson
Ericsson Business Innovation AB   Tel: +46 8 404 71 83
Viderögatan 3                     Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@inn.ericsson.se

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
