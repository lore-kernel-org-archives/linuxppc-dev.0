Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 622A5DDEDC
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 31 Mar 2007 13:51:17 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: PPC login puzzle
Date: Fri, 30 Mar 2007 20:51:02 -0700
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C069B6B@MERCURY.inside.istor.com>
References: <20070329192932.98FBD353A6C@atlas.denx.de>
	<200703291345.35978.tmaenner@aehr.com>
From: "Charles Krinke" <ckrinke@istor.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have 2 targets, both kernel.org linux-2.6.17.11. Both are currently =
using rootfile systems from montavista's 2.6.10 distribution. One is a =
PPC8241 and the other is a PPC8541.
=20
On the 8241, I can login with a telnet session as root. On the 8541, I =
cannot. On both, I can login at the serial terminal as root with no =
passwd.
=20
Neither as a password for root in /etc/passwd. That is, the first line =
in the passwd file says "root::0:0:root:/root/bin/bash".
=20
Being toasters, I dont want a password to cook my toast.
=20
The question is:
=20
"What are the various things that might cause one toaster to be able to =
login from a telnet session and another, very similar one to not be able =
to do this?"
=20
Charles
=20
