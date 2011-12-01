Return-Path: <jhautbois@gmail.com>
Received: from mail-ee0-f42.google.com (mail-ee0-f42.google.com [74.125.83.42])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id E61151007D1
 for <linuxppc-dev@ozlabs.org>; Thu,  1 Dec 2011 20:57:38 +1100 (EST)
Received: by eekb47 with SMTP id b47so1110603eek.15
 for <linuxppc-dev@ozlabs.org>; Thu, 01 Dec 2011 01:57:30 -0800 (PST)
MIME-Version: 1.0
From: Jean-Michel Hautbois <jhautbois@gmail.com>
Date: Thu, 1 Dec 2011 10:57:09 +0100
Message-ID: <CAL8zT=juU_PC92R4za31R8Lmur0PrFwog1m1fk+PEarW_0C6ng@mail.gmail.com>
Subject: Different behaviour when using "nosmp" parameter on SMP and UP
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I have a P2020 CPU (powerpc) and I compiled it with two different defconfigs.
The first one is a SMP, 2 cores, launched with the "nosmp" kernel
parameter, the other one is an UP kernel.

My driver behaviour is not the same whether launching one or the
other. It is hard to explain more precisely, as it deals only with
ioctl which only does ioread32/iowrite32 on a PCIe device.
But I can tell that it never works the same way when UP (not working
correctly), or SMP "nosmp" (working) or even SMP (not working).

AFAIK, the "nosmp" parameter should tell the kernel to act the same is
if it is an UP kernel, and it disables IO APIC, which is not an issue
in my case.

Can you think about anything that would explain it, or would help me
debugging it ?

Thanks in advance for your help.
Regards,
JM
