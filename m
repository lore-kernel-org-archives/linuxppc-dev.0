Return-Path: <j.borkhuis@dutchspace.nl>
Received: from kirk.dutchspace.nl (kirk.dutchspace.nl [193.200.147.14])
	by ozlabs.org (Postfix) with ESMTP id 1F7CDDDE05
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Sep 2007 21:29:42 +1000 (EST)
Received: from [10.21.30.78] (snitkin.dutchspace.nl [10.21.30.78])
	by kirk.dutchspace.nl (8.11.7p1+Sun/8.10.2) with ESMTP id l85BPNN23166
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 5 Sep 2007 13:25:23 +0200 (MEST)
Message-ID: <46DE9322.7080901@dutchspace.nl>
Date: Wed, 05 Sep 2007 13:29:38 +0200
From: Johan Borkhuis <j.borkhuis@dutchspace.nl>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Problems enabling NTP on ELDK
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I tried enabling NTP on my embedded machine (using ELDK 4.1, ppc_85xx, 
kernel version 2.6.14 with Xenomai 2.3.2). After I did that I noticed 
that ksoftirqd/0 suddenly took almost all processor time (> 95%). What 
is causing this? Is there a way around this, or is this something that 
does not cause any problems?

Kind regards,
    Johan Borkhuis
