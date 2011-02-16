Return-Path: <mitsutaka.amano@gmail.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 73F49B7118
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Feb 2011 15:28:29 +1100 (EST)
Received: by bwz10 with SMTP id 10so1228554bwz.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Feb 2011 20:28:23 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 16 Feb 2011 13:28:23 +0900
Message-ID: <AANLkTimW1yZ+H=X+j=TYMM8-zZx5XaEPczek05KtKKxN@mail.gmail.com>
Subject: Question about flash allocation
From: Mitsutaka Amano <mitsutaka.amano@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Why does CFI(or other flash memory) have to alloc amount of flash
memory size to the vmalloc area(such as PHYSMAP or PHYSMAP_OF)?
I wondered other devices seems to not allocating(e.g, most NAND flash,
flash on ARM, MIPS and so on). I don't know difference between my
board and other. Doesn't other devices need to allocate to vmalloc?

Thanks,
Mitsutaka
