Return-Path: <Leonid@a-k-a.net>
Received: from mis011.exch011.intermedia.net (mis011.exch011.intermedia.net
	[64.78.21.10]) by ozlabs.org (Postfix) with ESMTP id 1ED6EDDE0D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Aug 2007 12:47:03 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: Best Linux tree for Xilinx support.
Date: Mon, 13 Aug 2007 19:47:35 -0700
Message-ID: <406A31B117F2734987636D6CCC93EE3C02053A10@ehost011-3.exch011.intermedia.net>
In-Reply-To: <fa686aa40708102137o25b83daar82a40471756a3f2b@mail.gmail.com>
References: <20070806225642.7D72A7B005B@mail34-fra.bigfish.com><fa686aa40708091142n520f222amec7c6a76786c7fcc@mail.gmail.com>
	<fa686aa40708102137o25b83daar82a40471756a3f2b@mail.gmail.com>
From: "Leonid" <Leonid@a-k-a.net>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"Wolfgang Reissnegger" <wolfgang.reissnegger@xilinx.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi:

I have several boards with different architectures (Microblaze, PPC),
running Linux/uClinux and using Xilinx IP cores. I use both Virtex and
Spartan FPGAs.

Historically I'm using different kernels for them, starting from uClinux
2.4, all way through Linux 2.6.16 and 2.6.19. I patched them here and
there to get working.

I certainly feel a need to move to some standard kernel tree.

I understand that you guys are in some advanced steps of integrating
Xilinx into Linux. What would be my best choice of Linux kernel now?

I see the following options:

- download some GIT tree your are using (which one?).
- get latest tree from kernel.org and patch it using your patches (where
I can get them?).
- ??

Please advise,

Thanks,

Leonid.
