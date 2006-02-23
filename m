Return-Path: <dibacco@inwind.it>
Received: from smtp1.libero.it (smtp1.libero.it [193.70.192.51])
	by ozlabs.org (Postfix) with ESMTP id 4BDCF67A06
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Feb 2006 08:54:48 +1100 (EST)
Received: from localhost (172.16.1.209) by smtp1.libero.it (7.0.027-DD01)
	id 43E0E17C01E83C11 for linuxppc-embedded@ozlabs.org;
	Thu, 23 Feb 2006 22:54:44 +0100
Received: from smtp3.libero.it ([172.16.1.53])
	by localhost (asav22.libero.it [193.70.193.9]) (amavisd-new, port 10024)
	with ESMTP id 21143-06-7 for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Feb 2006 22:54:44 +0100 (CET)
Received: from libero.it (172.16.1.214) by smtp3.libero.it (7.0.027-DD01)
	id 431C39E001C8EC67 for linuxppc-embedded@ozlabs.org;
	Thu, 23 Feb 2006 22:54:44 +0100
Date: Thu, 23 Feb 2006 22:54:44 +0100
Message-Id: <IV5U78$180EB77EBEE4B7FA75E82AA727A7FFA2@libero.it>
Subject: Looping SPIMISO and SPIMOSI pins
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "dibacco\@inwind\.it" <dibacco@inwind.it>
To: "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

What could happen if I loop SPIMISO and SPIMOSI on my board expansion con=
nector? I think I should receive the messages I send on the SPI bus. SPI =
is  
full duplex?

Best regards,
Antonio.
