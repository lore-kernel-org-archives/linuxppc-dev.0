Return-Path: <albert.david@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.194])
	by ozlabs.org (Postfix) with ESMTP id E237D68110
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Sep 2005 16:11:40 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id i1so1112444nzh
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 07 Sep 2005 23:11:39 -0700 (PDT)
Message-ID: <61124de7050907230383654a6@mail.gmail.com>
Date: Thu, 8 Sep 2005 11:33:53 +0530
From: Albert David <albert.david@gmail.com>
To: linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: BDI2000 with PPC405EP
Reply-To: albert.david@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Friends,
I have been trying to find a solution to fix "PPC: timeout while
waiting for freeze" for my custom board.
BDI2000 keeps resetting the system with the following message...

TARGET: processing user reset request
TARGET: resetting target passed
TARGET: processing target startup ....
*** TARGET: core #0 startup failed # PPC: timeout while waiting for freeze
TARGET: target will be restarted in 10 sec

I tried all the possible solutions provided at
http://www.ultsol.com/faq-P206.htm for this perticular behaviour but
the problem remains same!

I have ensured that my Board's JTAG interface is properly working by
boundary scanning the pins of PPC405EP using UniversalScan software
with Altera-ByteBlaster MV.

for your information: twice i could succeed connecting BDI2000 with my
target! somehow it happen to work while i was trying to execute low
level JTAG commands such as 'rir' rdr'  and then after exiting(JTAG
command shell of BDI) it worked, but there is no consistency!

looks like my cpu core is not halting after asserting HALT line.
has anyone faced similar problem??

please help!
BR,
Albert David.
