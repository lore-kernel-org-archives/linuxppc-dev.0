Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "yhxing" <xyuhua_telecom@hotmail.com>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: How to control RTS signal ?
Mime-Version: 1.0
Content-Type: text/plain
Date: Fri, 19 Dec 2003 12:50:53 +0800
Message-ID: <Sea1-DAV34kO1dJFUuS0000e1ba@hotmail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

   Now we are using a mpc823 embedded system, and there is some trouble.
We need to use SCC3 UART to control RS485 tranceiver. TXD3 is connected
to RS485 tranceiver's D pin, RXD3 is connected to RS485 tranceiver's R
pin, and RTS3 is connected to RS485 tranceiver's RE# and DE pin. Then
when transmitting data, we hope RTS3 signal can keep low to enble D.
When receiving data, we hope RTS3 signal can keep high to enble R.
   So my question is, how can I program to control RTS3 signal in ppclinux.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
