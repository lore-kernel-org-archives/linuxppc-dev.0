Return-Path: <kernelppc@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.185])
	by ozlabs.org (Postfix) with ESMTP id F1BD6DDE9F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 May 2008 21:35:25 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id e27so1489692nfd.9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 May 2008 04:35:23 -0700 (PDT)
From: "mojtaba" <kernelppc@gmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Linux on Ml410
Date: Tue, 13 May 2008 13:36:54 +0200
Message-ID: <016601c8b4ed$a56e57a0$f04b06e0$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear all,

I am trying to run linux 1.6.25 on ML410 board. When the system boot I
receive this error:

loaded at:     00400000 004CD19C
board data at: 004CB120 004CB19C
relocated to:  00404050 004040CC
zimage at:     00404E3C 004CA0D1
avail ram:     004CE000 10000000

Linux/PPC load: console=ttyS0,115200 root=/dev/xsa2
Uncompressing Linux...inflate returned FFFFFFFD
exit

I will appreciate it if somebody can kindly answer me?
Regards,
Mojtaba
