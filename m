Return-Path: <DaveLiu@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id CCC9F67B2E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 May 2006 16:26:12 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k4O6aQPS006958 for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 May 2006 23:36:26 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k4O6Q8uN020116
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 May 2006 01:26:09 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD4673026FD914@zch01exm40.ap.freescale.net>
From: Liu Dave-r63238 <DaveLiu@freescale.com>
To: "'sandeep malik'" <malik_mca2000@yahoo.co.in>, linuxppc-embedded@ozlabs.org
Subject: RE: Help Needed: floating point used in kernel (task=c0398410, pc
	=3184)
Date: Wed, 24 May 2006 14:26:06 +0800
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Malik,

Because PPC8325 have NO float point unit, so please compile all of source code with gcc 8325 compiler
or use fixed simulate. The source code includs kernel, and filesystem.

Dave

-----Original Message-----

Hi All...

I am trying to run an application compiled with gcc toolchain gcc--3.4.3 and glibc -2.3.4 on PPC 8325 board running Linux 2.6.11....but some how I am getting following error....

floating point used in kernel (task=c0398410, pc=3184)
floating point used in kernel (task=c0398410, pc=3184)
floating point used in kernel (task=c0398410, pc=3184)
floating point used in kernel (task=c0398410, pc=3184)
floating point used in kernel (task=c0398410, pc=3184)
floating point used in kernel (task=c0398410, pc=3184)

I was suspecting this error might be because the hardware is not supporting floating point operations and hence i tried a simple program in which I intentionally did some floating point operation but that program was running as expected. So i concluded that it is not a problem related to floating point operations....I even tried compiling the application with classic ppc compiler(Ver 3.4.3) with -msoft-float option enabled, but still the results were same......

After these errors i am not able to get control of the system. If anyone who faced this or any such related issue please help me out like what could be probable reason for this error and what all options i have to debug this issue.....

Thanks & Regards,
Malik


Yahoo! India Answers Share what your know-how and wisdom
Send free SMS to your Friends on Mobile from your Yahoo! Messenger Download now
