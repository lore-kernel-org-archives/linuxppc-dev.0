Return-Path: <tauanna@tiscali.it>
Received: from mrqout2.tiscali.it (mrqout2.tiscali.it [195.130.225.12])
	by ozlabs.org (Postfix) with ESMTP id 867D467A6C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Jun 2006 07:38:55 +1000 (EST)
Received: from ps18 (10.39.75.88) by mail-6.mail.tiscali.sys (7.2.066.3)
	id 448EDB750002B3BE for linuxppc-embedded@ozlabs.org;
	Thu, 29 Jun 2006 23:29:31 +0200
Message-ID: <29672631.1151616571867.JavaMail.root@ps18>
Date: Thu, 29 Jun 2006 23:29:31 +0200 (CEST)
From: "tauanna@tiscali.it" <tauanna@tiscali.it>
To: linuxppc-embedded@ozlabs.org
Subject: SMC1 serial port blocks
MIME-Version: 1.0
Content-Type: text/plain;charset="UTF-8"
Reply-To: "tauanna@tiscali.it" <tauanna@tiscali.it>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have two identical linux boxes connected via a serial link (9600 
bit/s without any handshaking). In both boxes the serial port is 
realized by SMC1. One box is receiving and the other transmits a long 
stream of bytes. If I start the receiver after the transmitter, it 
seems that the transmitter cannot send anymore, even when I start the 
receiver. The transmitter has to be restarted to solve the problem.

Any help is appreciated,
Anna




		
Hai voglia di fare un viaggio, ma non sai dove andare?
Scegli una delle nostre offerte HOTEL IN ITALIA E IN EUROPA da 50 euro.
Prenota subito su Expedia.it e... buona vacanza!

http://expedia.viaggi.tiscali.it/default.aspx?eapid=330-8 
 
	
