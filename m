From: v.sudeep@exgate.tek.com
Message-ID: <301A812E6528D511A8F70008C71E578602B6D891@ap-bang-m02.india.tek.com>
To: laurent.mohin@acterna.com
Cc: linuxppc-embedded@lists.linuxppc.org,
	mporter@kernel.crashing.org, samsongshzu@yahoo.com.cn, wd@denx.de,
	xmiville@oerlikon.ca
Subject: RE: PCI daughter card with USB on a 405GP
Date: Thu, 26 Feb 2004 22:17:02 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi !!!

Mr Laurent ,
yes, I have disconnected the PCI daughter card. And yes, the kernel is
compiled without the usb related drivers (like you mentioned in your first
mail.)

- S u d e e p    V
Knowledge is the only instrument of production that is not subject to
diminishing returns.

-----Original Message-----
From: Laurent Mohin [mailto:laurent.mohin@acterna.com]
Sent: Thursday, February 26, 2004 8:53 PM
Subject: RE: PCI daughter card with USB on a 405GP

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

I don't see any PCI daughter card from your output. Have you
disconnected it to be able to boot? If yes, try to disable the usb
driver in your kernel, and see the result of the lspci command.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
