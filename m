Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <E1836A7F3557D311A14000805F9F36FCD4E383@usdfo011.usac.danfoss.net>
From: "Pergola, Michael" <MichaelPergola@Danfoss.com>
To: linuxppc-embedded@lists.linuxppc.org
Cc: "Support (E-mail)" <techsupport@embeddedplanet.com>
Subject: Serial Port problem with 823e on Embedded Planet
Date: Wed, 27 Jun 2001 13:50:17 -0400
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


All,

I have an Embedded Planet with a LITE_DW Motorola 823 PPC using a HIOX
interface board. I am trying to debug a program sending out data from
ttyS1 and reading it back in on ttyS2. The latest patch has been applied
for the tty ports (kernel 2.2.14).

I want to be able to send any char over the serial link, so I've resorted to
using "raw" mode. The problem is that if an overrun occurs on the receive
side, there is nothing I can sense to indicate this situation. Has anyone
run into this problem and/or is there a solution to my dilemma?

Regards,
     Michael Pergola
     Software Engineer
     Danfoss Air-Conditioning & Refrigeration Division
     7941 Corporate Blvd.
     Baltimore, MD  21236     (410) 931-8250 x4259


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
