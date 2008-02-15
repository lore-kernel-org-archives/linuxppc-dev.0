Return-Path: <severo.ricardo@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.178])
	by ozlabs.org (Postfix) with ESMTP id C0FE2DE710
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Feb 2008 05:40:48 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id z59so864315pyg.27
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Feb 2008 10:40:47 -0800 (PST)
Message-ID: <5ee408090802151040q4d7e2f70y3368f540c885bee6@mail.gmail.com>
Date: Fri, 15 Feb 2008 16:40:47 -0200
From: "Ricardo Ayres Severo" <severo.ricardo@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Boot freezes at memset_io in early_init
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

When booting the kernel, it freezes at this line in arch/ppc/setup.c:early_init
317        memset_io(PTRRELOC(&__bss-start), 0, _end - __bss_start);

I searched the list's archive and found this post [1] which has a
similar problem than I, but there isn't any solution posted.

What could be causing this?
I'm using the PPC405 in a Xilinux XUPV2P board with a Virtex II FPGA.

Thanks,

[1] http://ozlabs.org/pipermail/linuxppc-embedded/2004-August/015380.html

-- 
Ricardo Ayres Severo <severo.ricardo@gmail.com>
