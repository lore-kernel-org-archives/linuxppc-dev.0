Message-ID: <39DDF322.D48CE7AD@emc.com>
Date: Fri, 06 Oct 2000 11:43:30 -0400
From: Zhaobin Zhu <zzhu@emc.com>
MIME-Version: 1.0
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux boot failed on Sandpoint under baudrate 38400
References: <39DCEA5A.2E9DDE3C@emc.com> <14813.60363.648514.72914@igor.jsc.nasa.gov>
Content-Type: text/plain; charset=gb2312
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"\"Jeffrey D. Kowing\"

> You can use a kernel option to override what I believe is the default
> of 9600 when the kernel opens the serial port for use as the console.
> I have "console=ttyS0,38400" in my #define CMDLINE in
> arch/ppc/boot/misc.c.
>

This works.

Thanks

--
 Zhaobin Zhu
 zzhu@emc.com 508-435-1000 x12823
 Hardware Engineering, EMC Corporation


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
