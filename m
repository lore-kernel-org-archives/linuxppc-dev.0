Return-Path: <tauanna@tiscali.it>
Received: from mrqout2.tiscali.it (mrqout2.tiscali.it [195.130.225.12])
	by ozlabs.org (Postfix) with ESMTP id F19AB67A64
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Jul 2006 05:10:34 +1000 (EST)
Received: from ps13 (10.39.75.83) by mail-10.mail.tiscali.sys (7.3.110.2)
	id 4497D2AC0002A090 for linuxppc-embedded@ozlabs.org;
	Fri, 30 Jun 2006 21:10:32 +0200
Message-ID: <13853799.1151694631780.JavaMail.root@ps13>
Date: Fri, 30 Jun 2006 21:10:31 +0200 (CEST)
From: "tauanna@tiscali.it" <tauanna@tiscali.it>
To: linuxppc-embedded@ozlabs.org
Subject: rs232 endianness on PPC
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

Hi,

when I write a byte on the SMC1 (MPC875) serial device (let us say 
0x11) what should I expect on the output pin? First a 0 then 0, 0, 1, 
0, 0, 0, 1 or the opposite. Is it different on a little endian CPU?

Bye,
Antonio.




		
Hai voglia di fare un viaggio, ma non sai dove andare?
Scegli una delle nostre offerte HOTEL IN ITALIA E IN EUROPA da 50 euro.
Prenota subito su Expedia.it e... buona vacanza!

http://expedia.viaggi.tiscali.it/default.aspx?eapid=330-8 
 
	
