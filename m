Return-Path: <mcr@sandelman.ottawa.on.ca>
Received: from lists.sandelman.ca (cod.sandelman.ca [192.139.46.139])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "lists.sandelman.ca",
	Issuer "Michael Richardson" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5EDF0679E9
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Mar 2006 07:43:25 +1100 (EST)
To: "Wyse, Chris" <chris.wyse@windriver.com>
Subject: Re: Calling PCI Autoconfig again 
In-Reply-To: Message from "Wyse, Chris" <chris.wyse@windriver.com> of "Mon,
	06 Mar 2006 13:34:57 PST."
	<927594BA71733F4BAA815162B79A3F513B27FD@ala-mail04.corp.ad.wrs.com>
References: <927594BA71733F4BAA815162B79A3F513B27FD@ala-mail04.corp.ad.wrs.com>
Date: Tue, 07 Mar 2006 10:48:06 -0500
Message-ID: <28658.1141746486@sandelman.ottawa.on.ca>
From: Michael Richardson <mcr@sandelman.ottawa.on.ca>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


You need some kind of hotplug PCI interface to make this work.

When I last tried this -- for the same reason --- it was hard because we
couldn't get the physical memory map from the (PC) BIOS.  (This was
before ACPI 2.0...)

Since you have complete control over the board, you should have this
information already. 

- -- 
]       ON HUMILITY: to err is human. To moo, bovine.           |  firewalls  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net architect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Finger me for keys

iQEVAwUBRA2rNICLcPvd0N1lAQLchQf9E6B6ISMnpam5rgCXe67RQz3IWseOMtAb
8m65WKBDwTUxwKIwiOygY0AnLudL4+dSKp8QaswXsjl4g7BvjVBwjWH0itmIvWew
1V0BUVJUNMpzYH7I9fEtbJXjQvN/8VyJRX+7HIndvH1CWpeDzHgQTAVu+CIVfyGI
SEEZsgwzgq8mzbopawxPORd+rKv9F6tlnbqAU8P1eHB8wcUEu+WZQ+oA3WGS+Zhn
5ZjK3dX+QXI2JykicyS7VVUT5D6vaZFon4Ikk4Ao0JKfNHmAD7fN4BHhORrpGYyR
+dHlRZlZiRfw3AEoqg6XZZrcGWfciBK8mD6utPnSHomMsaTk80jbtQ==
=o2Wv
-----END PGP SIGNATURE-----
