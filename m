Return-Path: <ashok.hegde@motorola.com>
Received: from ftpbox.mot.com (ftpbox.mot.com [129.188.136.101])
	by ozlabs.org (Postfix) with ESMTP id 8F9AD67A79
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  7 Mar 2005 21:33:51 +1100 (EST)
Received: from il06exr04.mot.com (il06exr04.mot.com [129.188.137.134])
	by ftpbox.mot.com (Motorola/Ftpbox) with ESMTP id j27AXnoR024058
	for <linuxppc-embedded@ozlabs.org>; Mon, 7 Mar 2005 03:33:49 -0700 (MST)
Received: from zin24exm01.ap.mot.com (zin24exm01.ap.mot.com [10.232.25.1])
	by il06exr04.mot.com (8.13.1/8.13.0) with ESMTP id j27AYPNF003121
	for <linuxppc-embedded@ozlabs.org>; Mon, 7 Mar 2005 04:34:26 -0600 (CST)
Message-ID: <772BCEF88A1DD91191F80011856715F301C2B56C@zin24exm01.ap.mot.com>
From: Hegde Ashok-aah024 <ashok.hegde@motorola.com>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 7 Mar 2005 16:03:33 +0530 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: MV64360 MPSC - console problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,

  I am trying to bring up linux-2.6.10 on ppc based system with
MV64360(marvell controller).
I am unable to use mpsc as the console, serial text debug messages are
coming fine i.e. ppc_md.progress able to print properly on the serial port.
I observed that  when console_init() is being called from init/main.c  none
of our "mpsc" init functions are called.
Also I see that there is no call to "console_initcall" in mpsc driver.
According to my understanding this call is required in serial drivers used
as consoles.
 I took this mpsc driver from "bk://source.mvista.com/linux-2.5-marvell" as
mentioned in ppc mailinglist.
   Hardware has been tested with linux-2.4.20 flavour and it is absolutely
fine.

Appreciate any help.

Thanks,
Ashok
