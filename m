Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: CAN device driver for TQM8xxL
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Tue, 27 Mar 2001 09:12:18 +0200
Message-ID: <72630D03E1DBE24281730D8F975876290B794D@tepc07.tz-mikroelektronik.de>
From: "Brau Gunther" <gunther.brau@tz-mikroelektronik.de>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello "Linux for PowerPC" friends!

I would like to offer you a simple CAN device driver for
TQM8xxL Minimodules which I wrote some weeks ago.

A few notes must be considered to use this software:
* So far NO Interrupts are supported!
  Because I'm a Linux beginner and I don't know how to do..
  I hope that someone will complete the code (and publish it too)!
* ..and that someone will have pleasure to extend the
  CAN device driver e.g. to a CANopen driver? (and publish it too)!
* The CAN device driver (Source: can.c/.h) and the library functions
  (Source: can_lib.c/.h) are NOT tested in detail (but sending and
  receiving work fine ;-)
  Please feel free and correct errors (and publish it too)!
* I and the company TZM make no warranty for nothing at all.

And here you can find the files (CAN.TGZ and CAN_DEMO.TGZ):
ftp://dev.linuxppc.org/incoming


Info:
The TQM8xxL Minimodules have 2 CAN controllers Intel 82527 on board.
The UPMB is used to access the CAN controllers (with CS3#).
IRQ4# is used for Interrupts (Error INT and Status Change INT).



Mit freundlichen Grüßen
  (With kind regards)
      Gunther Brau

_____________________________________________________________________

TransferZentrum Mikroelektronik

Dipl.-Ing. (FH) G. Brau
Entwicklung  (Development)

Robert-Bosch-Straße 1
D-73 037 Göppingen
Phone.: +49  (0 71 61)  679 -212
Fax.:   +49  (0 71 61)  679 -245
mailto:gunther.brau@tz-mikroelektronik.de
visit our website on http://www.tz-mikroelektronik.de
look at my latest product on
http://www.tz-mikroelektronik.de/ServiceModule/index.html
______________________________________________________________________

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
