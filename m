Return-Path: <Adam.Zajac@motorola.com>
Received: from motgate8.mot.com (motgate8.mot.com [129.188.136.8])
	by ozlabs.org (Postfix) with ESMTP id 840EA2BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Oct 2004 07:55:27 +1000 (EST)
Received: from il06exr03.mot.com (il06exr03.mot.com [129.188.137.133])
	by motgate8.mot.com (Motorola/Motgate8) with ESMTP id i9LLufG2016911
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Oct 2004 14:56:41 -0700 (MST)
Received: from tx14exm06.ftw.mot.com (tx14exm06.ftw.mot.com [10.63.167.204])
	by il06exr03.mot.com (Motorola/il06exr03) with ESMTP id i9LLtIbs013881
	for <linuxppc-embedded@ozlabs.org>; Thu, 21 Oct 2004 16:55:18 -0500
Message-ID: <EFB813091B18D511BD3600508B644F820A618202@tx14exm06.ftw.mot.com>
From: Zajac Adam-AAZ004 <Adam.Zajac@motorola.com>
To: "'VanBaren, Gerald (AGRE)'" <Gerald.VanBaren@smiths-aerospace.com>,
	"'Eugene Surovegin'" <ebs@ebshome.net>
Date: Thu, 21 Oct 2004 16:55:13 -0500
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Help on tuning the Linux kernel for soft real-time requiremen ts
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Gerald, Eugene,

Thanks a bunch for your inputs.
I've done a lot of different experiments that included using different
storage media and the problem has been narrowed down to a serial driver
contention.

>I would be suspicious that one of your drivers is blocking interrupts
>for long durations, your mass storage driver in particular, although
>serial consoles are also known for rude behavior as well.
>
Gerald, you may be right about this. Although I still don't know which of
the threads in our system cause the serial resource contention, I
temporarily alleviated the problem with limiting the messages that are being
printed out to the screen.

BTW, are you guys aware of any tool that could help me debug the threads
that would concurrently try to access shared resources?
Do you think LTT would be helpful for this particular problem (serial driver
contention that leads to missing soft real-time deadlines)?

Adam
