Return-Path: <Adam.Zajac@motorola.com>
Received: from ftpbox.mot.com (ftpbox.mot.com [129.188.136.101])
	by ozlabs.org (Postfix) with ESMTP id E291E2BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Oct 2004 05:00:13 +1000 (EST)
Received: from az33exr01.mot.com (az33exr01.mot.com [10.64.251.231])
	by ftpbox.mot.com (Motorola/Ftpbox) with ESMTP id i9MJ044D015054
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Oct 2004 12:00:04 -0700 (MST)
Received: from tx14exm06.ftw.mot.com (tx14exm06.ftw.mot.com [10.63.167.204])
	by az33exr01.mot.com (Motorola/az33exr01) with ESMTP id i9MIq2UE025118
	for <linuxppc-embedded@ozlabs.org>; Fri, 22 Oct 2004 13:52:02 -0500
Message-ID: <EFB813091B18D511BD3600508B644F820A618204@tx14exm06.ftw.mot.com>
From: Zajac Adam-AAZ004 <Adam.Zajac@motorola.com>
To: "'wd@denx.de'" <wd@denx.de>
Date: Fri, 22 Oct 2004 13:59:54 -0500
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Help on tuning the Linux kernel for soft real-time requiremen
	ts
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Wolfgang,

>I'm not exaclty sure I really understand what  you  are  asking  for.
>Isn't  sometimes  missing  the  deadlines what the "soft" is standing
>for? ;-)

I'm certainly not the one who would attempt to define the distinction
between hard and soft real-time requirements (beyond the obvious notion of
an absolute deterministic and an average response time). Just used that term
casually as we wanted to meet application deadlines that were in order of
seconds with some small room for a response variation (+/- milliseconds).
What I referred to as "missed deadlines" were slips in order of +/- 20
seconds. This was way out of line.

Do you know if sysstat RPM is available for PPC?
It'd be nice to have tools like sar and iostat for debugging my problem.

Regards,
Adam
