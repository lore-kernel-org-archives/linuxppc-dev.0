Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <E1836A7F3557D311A14000805F9F36FCD4E3FE@usdfo011.usac.danfoss.net>
From: "Pergola, Michael" <MichaelPergola@Danfoss.com>
To: linuxppc-embedded@lists.linuxppc.org
Cc: "Support (E-mail)" <techsupport@embeddedplanet.com>
Subject: Async HDLC for 823e SCC
Date: Tue, 14 Aug 2001 10:51:28 -0400
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

I have an Embedded Planet with a LITE_DW
Motorola 823e PPC
using a HIOX interface board.

Is there an implementation of using the SCC in
Asynchronous HDLC mode?

I think that the commproc structures might need
to be altered to use this mode. The UART cbd_t
structure are similar but some flags are different.


Regards,
     Michael Pergola
     Software Engineer
     Danfoss Air-Conditioning & Refrigeration Division
     7941 Corporate Blvd.
     Baltimore, MD  21236     (410) 931-8250 x4259


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
