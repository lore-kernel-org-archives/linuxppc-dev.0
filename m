MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: How to setup writethrough cache
Date: Wed, 30 Apr 2003 15:47:50 +0200
Message-ID: <9367F79C9DBB8147AD58A96C933F008603BDF4@men-exch.intra.men.de>
From: "Klaus Popp" <Klaus.Popp@men.de>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi folks,

does anybody know how to map I/O space into kernel space with "cache write through" attributes?
I need it to speed up reads from graphics memory.

AFAIK, there is no difference between ioremap() and ioremap_nocache() on PPC. Any hints?

Klaus Popp
MEN Mikro Elektronik GmbH
Klaus.Popp@men.de
www.men.de

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
