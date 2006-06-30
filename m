Return-Path: <Martin.Krause@tqs.de>
Received: from mail.tqs.de (mail.tqs.de [62.157.136.17])
	by ozlabs.org (Postfix) with ESMTP id E5D2467B4E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Jun 2006 16:51:53 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: SMC1 serial port blocks
Date: Fri, 30 Jun 2006 08:34:12 +0200
Message-ID: <47F3F98010FF784EBEE6526EAAB078D1024F8152@tq-mailsrv.tq-net.de>
In-Reply-To: <29672631.1151616571867.JavaMail.root@ps18>
From: "Martin Krause" <Martin.Krause@tqs.de>
To: <tauanna@tiscali.it>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

linuxppc-embedded-bounces+martin.krause=3Dtqs.de@ozlabs.org wrote on
Thursday, June 29, 2006 11:30 PM:=20
> I have two identical linux boxes connected via a serial link (9600
> bit/s without any handshaking). In both boxes the serial port is
> realized by SMC1. One box is receiving and the other transmits a long
> stream of bytes. If I start the receiver after the transmitter, it
> seems that the transmitter cannot send anymore, even when I start the
> receiver. The transmitter has to be restarted to solve the problem.

Are you really sure, you don't use handshaking? You could try to connect
your boxes via three signal lines only: RxD, TxD and GND. This should
ensure that no (hardware) handshaking is involved.

Martin
