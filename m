Return-Path: <robin@india.tejasnetworks.com>
Received: from pop-mail.india.tejasnetworks.com (pop.india.tejasnetworks.com
	[164.164.94.84]) by ozlabs.org (Postfix) with SMTP id 4A6AB67A87
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Feb 2005 20:40:25 +1100 (EST)
Received: from kilbil (unknown [192.168.1.59])
	by india.tejasnetworks.com (*****) with ESMTP id E0B959B323
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Feb 2005 14:57:04 +0530 (IST)
Content-Type: text/plain;
  charset="iso-8859-1"
From: robin <robin@india.tejasnetworks.com>
To: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Date: Tue, 15 Feb 2005 15:09:42 +0530
References: <EA78B62757AF1E4799828249310AC4CA071D281F@stca206a.bus.sc.rolm.com>
	<28F2CE72-0BF0-11D9-97DC-003065F9B7DC@embeddededge.com>
	<20050210150437.GA19134@logos.cnet>
In-Reply-To: <20050210150437.GA19134@logos.cnet>
MIME-Version: 1.0
Message-Id: <200502151509.42223.robin@india.tejasnetworks.com>
Subject: Reading of RTC
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
Can you please give me some info during system initialization?

1. Which file does the reading of RTC to set the system time?

   In redhat, i have seen that the RTC is set from the script=20
   /etc/rc.d/rc.sysinit. But my MPC /etc/rc.d/rc.sysinit does
   not seem to do anything like that:(

2. How does the kernel interprets the time read from the RTC?
   Is it interpreted as UTC or the local time?? Or is it configurable??

I am running denx kernel 2.4.20
Regards,
Robin

--=20
Dreams are free, but you get soaked on the connect time.
