Mime-Version: 1.0
Message-Id: <p04330108b5fe3b1aca7d@[130.227.158.132]>
Date: Mon, 2 Oct 2000 15:20:28 +0200
To: linuxppc-dev@lists.linuxppc.org
From: "Povl H. Pedersen" <pope@netguide.dk>
Subject: Post-2.2.15 ethernet trouble. Kernel problem ?
Content-Type: text/plain; charset="iso-8859-1" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have a few powerMac 7200 I would like to be VPN gateways on a few
locations, and I would like to run with the latest kernel. I have one
problem though, and that is that kernel 2.2.15 works.

Later kernels DO NOT work with the built-in ethernet, neither with
the netdrivers from scyld a via-rhine card. This driver works on
2.2.15 as well.

My card is able to get an IP address using DHCP, then gets a few
packets, and starts dropping everything from then on. This is true
for both cards. So I guess it is a kernel thing ?

Any advice welcome.
--

NetGuide Danmark aps
Povl H. Pedersen, Chief Technology Officer

Member of the Catenas network.

ÅRHUS: Skolegade 19A, DK-8000 Aarhus C.
KØBENHAVN: Forskerbyen Symbion, box 367, Fruebjergvej 3. DK-2100 København Ø
HELSINGBORG: Bredgatan 6, 25114 Helsingborg, Sverige
KAMPALA:  Bukoto Street 23, Kamwokya, P.O.Box 28483, Kampala, Uganda

Phone +45  8618 1845 - Fax +45 8618 1863 - GSM +45 4093 5511
E-mail: pope@netguide.dk - PGP Key ID: 0x8F4BC755
URL: http://www.netguide.dk

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
