Return-Path: <hongwoo7@gmail.com>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.243])
	by bilbo.ozlabs.org (Postfix) with ESMTP id A245DB7066
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 18 Jul 2009 19:25:00 +1000 (EST)
Received: by rv-out-0708.google.com with SMTP id c5so290592rvf.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 18 Jul 2009 02:24:58 -0700 (PDT)
Message-ID: <4A6194D8.9090602@gmail.com>
Date: Sat, 18 Jul 2009 18:24:40 +0900
From: HongWoo Lee <hongwoo7@gmail.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Simple question about powerpc asm. 
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

I was reading kernel level source and found this macro.

#define SET_REG_TO_LABEL(reg, label)                \
    lis     reg,(label)@highest;                    \
    ori     reg,reg,(label)@higher;                 \
    rldicr  reg,reg,32,31;                          \
    oris    reg,reg,(label)@h;                      \
    ori     reg,reg,(label)@l;

But, I couldn't find any clue related with @highest, @higher, @h, @l.

If anybody know about this directives(?), please explain it.
Or just let me know the keyword, so I can search with those keyword.

Thanks in advance.

HongWoo.
