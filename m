Return-Path: <kiranf5@lycos.com>
Received: from fallback.us4.outblaze.com (fallback.us4.outblaze.com
	[205.158.62.120]) by ozlabs.org (Postfix) with ESMTP id 5A21C68968
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Dec 2005 22:55:01 +1100 (EST)
Received: from webmail-outgoing.us4.outblaze.com
	(webmail-outgoing.us4.outblaze.com [205.158.62.67])
	by fallback.us4.outblaze.com (Postfix) with ESMTP id E718C1C05DD1
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Dec 2005 11:21:15 +0000 (GMT)
Received: from unknown (unknown [192.168.9.180])
	by webmail-outgoing.us4.outblaze.com (Postfix) with QMQP id
	D341A18002B7 for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Dec 2005 11:21:11 +0000 (GMT)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
From: "Kiran Kumar.A" <kiranf5@lycos.com>
To: benh@kernel.crashing.org
Date: Fri, 30 Dec 2005 06:21:11 -0500
Message-Id: <20051230112111.58191CA092@ws7-4.us4.outblaze.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Regarding booting 440 gr board / ibm emac driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Benjamin,
This is kiran here. I'm working on 440GR (Yosemite) board to boot linux-2.6=
.13.4.
Everything works fine execpt for MAC address. I saw the code in arch/ppc/pl=
atforms/4xx/yosemite.c; the code to copy the MAC addr from board info struc=
ture seems to be in place. I am  using IBM emac driver written by you.
Linux boots up fine and  in the booting messages , I see that the MAC addr =
is displayed as all zeroes. Also, the ifconfig displays the MAC address as =
all zeroes.=20=20

Could you please throw some light on the same.=20
What could be the issue? Do we need to modify the driver for MAC address is=
sue??


regards,
kiran



--=20
_______________________________________________

Search for businesses by name, location, or phone number.  -Lycos Yellow Pa=
ges

http://r.lycos.com/r/yp_emailfooter/http://yellowpages.lycos.com/default.as=
p?SRC=3Dlycos10
