Return-Path: <linuxdev.baldrick@gmail.com>
Received: from mail-io0-x242.google.com (mail-io0-x242.google.com
 [IPv6:2607:f8b0:4001:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdM0T6yx8zDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 18:04:25 +1000 (AEST)
Received: by mail-io0-x242.google.com with SMTP id t74so22605468ioi.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 01:04:25 -0700 (PDT)
MIME-Version: 1.0
From: David Binderman <linuxdev.baldrick@gmail.com>
Date: Mon, 27 Jun 2016 09:04:23 +0100
Message-ID: <CAMzoama3BkAfxqzEt2khiPOcKxkOP1JVSx5UcCwWvGJLGrzLtA@mail.gmail.com>
Subject: arch/powerpc/xmon/dis-asm.h: 2 * wrong specifiers ?
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dcb314@hotmail.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello there,

linux-4.7-rc5/arch/powerpc/xmon/dis-asm.h:20]: (warning) %x in format
string (no. 1) requires 'unsigned int' but the argument type is
'unsigned long'.
[linux-4.7-rc5/arch/powerpc/xmon/dis-asm.h:26]: (warning) %x in format
string (no. 1) requires 'unsigned int' but the argument type is
'unsigned long'.

Source code is

static inline int print_insn_powerpc(unsigned long insn, unsigned long memaddr)
{
    printf("%.8x", insn);
    return 0;
}

static inline int print_insn_spu(unsigned long insn, unsigned long memaddr)
{
    printf("%.8x", insn);
    return 0;
}

Regards

David Binderman
