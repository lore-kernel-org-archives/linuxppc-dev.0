Return-Path: <Josef.Angermeier@informatik.uni-erlangen.de>
Received: from max71.rrze.uni-erlangen.de (max71.rrze.uni-erlangen.de
	[131.188.3.181]) by ozlabs.org (Postfix) with ESMTP id EAEF667A2E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Aug 2006 18:02:45 +1000 (EST)
Received: from max71.rrze.uni-erlangen.de (max71.rrze.uni-erlangen.de
	[131.188.3.181]) by max71.rrze.uni-erlangen.de with ESMTP for
	linuxppc-embedded@ozlabs.org; Fri, 4 Aug 2006 10:02:28 +0200
Received: from max71.rrze.uni-erlangen.de ([131.188.3.181])
	by max71.rrze.uni-erlangen.de (max71.rrze.uni-erlangen.de [127.0.0.1])
	(amavisd-new)
	with ESMTP id 11623-06-1688 for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Aug 2006 10:02:27 +0200 (MEST)
Received: from [131.188.51.43] ([131.188.51.43] [131.188.51.43]) by
	mailhub.rrze.uni-erlangen.de with ESMTP for
	linuxppc-embedded@ozlabs.org; Fri, 4 Aug 2006 10:02:27 +0200
Message-Id: <44D2FF19.20500@cs.fau.de>
Date: Fri, 04 Aug 2006 10:02:33 +0200
From: Josef Angermeier <Josef.Angermeier@informatik.uni-erlangen.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Help for USB host driver for MPC8xx
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


Hello Wei,

i ported Brad Parkers mpc8xx usb driver for linux 2.4 to linux 2.6 and merged it with the cpm2usb project's m82xx usb driver. Using it i can mount an usb-stick with linux 2.6.18 running on a m8xx. But for sure, there have to get some more bugs fixed, and i have to validate that the included cpm2usb code for m82xx still works, before i can send a patch for an official linux release.

So if you like i will send you my code and you tell me if it also works for your needs!

Josef


Hi All,

Dose anyone use USB host drivers for MPC875 with Linux 2.4.25? I just 
found these notes from http://www.heeltoe.com/software/usb/usb.html, 
but I have no idea about how to use it, any advice? Thanks.

Wei
