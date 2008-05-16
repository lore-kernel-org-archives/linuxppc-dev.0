Return-Path: <kernelppc@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id 213ABDE0AF
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 May 2008 21:56:13 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id j3so1449650ugf.0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 May 2008 04:56:11 -0700 (PDT)
From: "mojtaba" <kernelppc@gmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Booting Linux from an ACE File
Date: Fri, 16 May 2008 13:57:35 +0200
Message-ID: <007a01c8b74c$0ad9c2e0$208d48a0$@com>
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

Could you please explain what happens exactly when Linux is booting from a
compact flash?

To my few knowledge, the Linux compressed image will be copied somewhere in
memory, will be uncompressed and the control will jump to the beginning
address of the Linux kernel.

Is there any boot loader that copies the Linux compressed image to the
memory?

Where in memory does it put the Linux kernel? For example, if I have 2 DDRs
in my hardware, in which of them it will be put the kernel?

Can I set the kernel location in memory manually?

Might be an stupid question but: Is it possible for the kernel to be half in
BRAMS and half in DDR?

Regards,
Moji
