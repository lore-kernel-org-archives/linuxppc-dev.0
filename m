Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Linker problem
Date: Tue, 22 Oct 2002 09:54:32 +0200
Message-ID: <1E354700654661418593A0D6B5A9D41008946D@mail.azisa.co.za>
From: "Flavio Pereira" <fpereira@azisa.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All

Im trying to cross compile some c++ code for the 8260 chip. However when
the linker executes it return the following error:

undefined reference to `__throw'

Can anyone please give some advice on how to tackle this problem? What
does this mean? Does it have anything to do with c++ libraries??? Im
using the cross compile environment set up by the ELDK Kit from DENX.

Regards
Flavio Pereira

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
