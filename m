Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "gguevel" <gguevel@interfaceconcept.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: How to receive IP and RAW frames on the same ethernet device ?
Date: Mon, 9 Sep 2002 19:23:42 +0200
Message-ID: <000001c25825$a572e5c0$3101a8c0@DOMAIN>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: 
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I work on a custom 860 board with Linux 2.2.14.

I want to receive and send IP and RAW frames simultaneously on the same
ethernet device.

I don't know if I can use ethertap driver or something else.

I don't understand why I must "ifconfig" the ethertap with an ip address if
I just want raw
frames like LLC frames.

Has anybody a good idea ?

Thanks

Gérard Guével


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
