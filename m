Return-Path: <cchaoyu@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.199])
	by ozlabs.org (Postfix) with ESMTP id EE95F68212
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Sep 2005 00:30:48 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i8so1627922wra
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Sep 2005 07:30:44 -0700 (PDT)
Message-ID: <56c9934305091207234d14d309@mail.gmail.com>
Date: Mon, 12 Sep 2005 22:23:40 +0800
From: chao yu <cchaoyu@gmail.com>
To: linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: Why IRQ8 infects the timer on mpc8541?
Reply-To: cchaoyu@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, All
    I am working for a project based on mpc8541. Decrementer was ok
when external interrupt was disabled( in my board, IRQ8 connected to
other PCI device, EIVPR8 value was 0x8001000B ), but when i set the
value 0x0000100B to EIVPR to set IRQ8 enable, decrementer does not
work( IP will not go to 0x900 offset).

Who can give a hand?

Thanks

Regards,
cchaoyu
