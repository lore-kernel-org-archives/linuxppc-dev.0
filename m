MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: PCI on 826x
Date: Tue, 16 Mar 2004 12:49:12 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B06DA90@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I have a problem getting linux (2.4 and 2.6) to setup PCI IO space
correctly.
U-Boot sets everything up correctly (and it works). Then when Linux
boots, it remaps the IO area from F4000000 to E8000000. And I cannot see
that the SIU PCIBR registers are updated anywhere.

When I try to access the IO area I get buserrors.

I know this is not enough info, but I need some pointers to where to
look to get it going.

Board is basically a MPC8266ADS board.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
