Return-Path: <marc.leeman@gmail.com>
Received: from mproxy.gmail.com (rproxy.gmail.com [64.233.170.203])
	by ozlabs.org (Postfix) with ESMTP id 50DE72BDAB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Sep 2004 23:40:01 +1000 (EST)
Received: by mproxy.gmail.com with SMTP id 76so4364833rnl
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Sep 2004 06:39:57 -0700 (PDT)
Message-ID: <1f729c4804092806332aaf052e@mail.gmail.com>
Date: Tue, 28 Sep 2004 15:33:16 +0200
From: Marc Leeman <marc.leeman@gmail.com>
To: Linux PowerPC Embedded Mailinglist <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: throughput question
Reply-To: Marc Leeman <marc.leeman@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I see some mails passing over the list about gigabit interfaces, so I
wonder if there are any suggestions as to what processor/interface
should be used for high througput.

I am currently working on a 8245 based board with 2.4.27 e100 driver
and when taking in (and processing streams), only about 50 Mbps can be
handled: about half of the time is based in kernel space (handling
interrupts).

The eepro100 driver was much worse.

As a result, I am a bit wondering about the higher bitrates. How much
do you achieve on tests with what hardware?

--=20
ash nazg durbatul=FBk, ash nazg gimbatul,
ash nazg thrakatul=FBk agh burzum-ishi krimpatul
