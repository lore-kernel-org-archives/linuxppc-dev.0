Return-Path: <rupesh.sugathan@gmail.com>
Received: from mproxy.gmail.com (rproxy.gmail.com [64.233.170.204])
	by ozlabs.org (Postfix) with ESMTP id B5B0D2BDB8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Oct 2004 07:31:31 +1000 (EST)
Received: by mproxy.gmail.com with SMTP id 75so679903rnl
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Oct 2004 14:31:30 -0700 (PDT)
Message-ID: <1e44ebcf04101214247d3072b6@mail.gmail.com>
Date: Tue, 12 Oct 2004 14:24:50 -0700
From: Rupesh S <rupesh.sugathan@gmail.com>
To: linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: PPC kernel hangs
Reply-To: Rupesh S <rupesh.sugathan@gmail.com>
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

To perform a Memory Mapped access of a device, I setup the OR and BR
registers in the bootloader (u-boot). I am able to read and write to
the device being in the u-boot prompt. However, when I try to access
the device after the Linux kernel boots up (say, in a driver), it
gives me a exception message as follows.
#################################################################
enabl0004, DSISR: 00000063
TASK = c3ef4000[18] 'insmod' Last syscall: 128
last math 00000000 last altivec 00000000
GPR00: C60B0338 C3EF5E50 C3EF4000 60000004 00001032 00000001 C018009E C60B0000
GPR08: C60B0BB8 C60B085C C60B0BBC C60B0000 C0180000 10056374 00000000 00000000
3
TASK = c3ef4000[18] 'insmod' Last syscall: 128
last math 00000000 last altivec 00000000
GPR00: C60B0338 C3EF5E50 C3EF4000 60000004 00001032 00000001 C018009E C60B0000
GPR08: C60B0BB8 C60B085C C60B0BBC C60B0000 C0180000 10056374 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 00009032 C3EF5E98 10064EBC C3E2C000
GPR24: C02EEA80 00000008 C60B2000 00000060 FFFFFFEA 00000000 C60B0000 C60B0000
Call backtrace:
00000000 C60B0338 C0014DE4 C000447C 10050000 1000B27C 1000C344
10003CBC 100038C8 0FE70E88 00000000
#################################################################

My platform is MPC880 Processor.

Do I need to setup something more in the kernel?

-- 
Rupesh S
