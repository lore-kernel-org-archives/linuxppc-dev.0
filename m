To: v.sudeep@exgate.tek.com
Cc: linuxppc-embedded@lists.linuxppc.org,
	mporter@kernel.crashing.org, samsongshzu@yahoo.com.cn, wd@denx.de,
	xmiville@oerlikon.ca
Subject: RE: PCI daughter card with USB on a 405GP
MIME-Version: 1.0
Message-ID: <OF073609E6.7694C121-ONC1256E46.0053AAA6-C1256E46.00549D37@se.wavetek.com>
From: "Laurent Mohin" <laurent.mohin@acterna.com>
Date: Thu, 26 Feb 2004 16:22:33 +0100
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

lspci command gives you a dump of the configuration registers of your
PCI devices. In your example, it detects only the IBM405GP PCI bridge

The initial lines are a text traduction of what was read:

00:00.0 Host bridge: IBM 405GP PLB to PCI Bridge (rev 01)
...

The last four lines are an hex dump
00: 14 10 56 01 06 00 10 22 01 00 00 06 00 07 00 00

10: 00 00 00 00 08 00 00 00 00 00 00 00 00 00 00 00

20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

30: 00 00 00 00 58 00 00 00 00 00 00 00 00 01 00 00

(14 10 and 56 01 are PCI vendor ID and PCI device ID for the 405GP - be
careful PCI is little endian whereas 405GP is big endian)

I don't see any PCI daughter card from your output.
Have you disconnected it to be able to boot?
If yes, try to disable the usb driver in your kernel, and see the result
of the lspci command.

Laurent MOHIN
ACTERNA

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
