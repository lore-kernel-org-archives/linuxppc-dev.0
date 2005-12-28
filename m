Return-Path: <happyphot@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.204])
	by ozlabs.org (Postfix) with ESMTP id 5AADE688E3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Dec 2005 16:52:45 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id z31so1339114nzd
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Dec 2005 21:52:44 -0800 (PST)
Message-ID: <007801c60b72$eb4988c0$0860120a@photon>
From: "HappyPhot" <happyphot@gmail.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Wed, 28 Dec 2005 13:52:36 +0800
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="big5"; reply-type=original
Subject: Error: unknown pseudo-op: `.cfi_startproc'
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dears,
  I am using ELDK (2005-06-07) and linux-2.6.15-rc2-2005-12-03-2208.tar.bz2
to build the kernel. But there are some errors:

.../arch/powerpc/kernel/vdso32/gettimeofday.S: Assembler messages:
.../arch/powerpc/kernel/vdso32/gettimeofday.S:28: Error: unknown pseudo-op: 
`.cfi_startproc'
.../arch/powerpc/kernel/vdso32/gettimeofday.S:30: Error: unknown pseudo-op: 
`.cfi_register'
.......

Anybody knows what happened ? And is there any way to solve ?

Thank you for your help.
/HappyPhot 
