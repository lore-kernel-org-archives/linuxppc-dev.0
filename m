Return-Path: <wojciech.kromer@dgt.com.pl>
Received: from dgt.com.pl (mail.dgt.com.pl [195.117.141.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 394BE68378
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Oct 2005 19:31:13 +1000 (EST)
Message-ID: <43463C92.403@dgt.com.pl>
Date: Fri, 07 Oct 2005 11:14:58 +0200
From: Wojciech Kromer <wojciech.kromer@dgt.com.pl>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: mpc8248 and FCC ethernet
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

What are differences between using FCC in u-boot and kernel?

I have fine working u-boot on my new mpc8248 board,
I can sucessfully download kernel via ethernet on FCC1.

But inside kernel all RX frames are filled with 0xff data,
also send frames I can see on the other side, are full of 0xff.
Clocks and other FCC aware registers seems to be correct.
The same version on linux (2_4_devel from denx.de) works fine
on another mpc8260 board.

Any hints? Where to find differences?
What should be important to check?
