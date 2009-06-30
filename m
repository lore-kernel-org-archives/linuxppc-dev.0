Return-Path: <johnny.hacking@gmail.com>
Received: from mail-gx0-f208.google.com (mail-gx0-f208.google.com
	[209.85.217.208])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 36CB0B709A
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 11:36:53 +1000 (EST)
Received: by gxk4 with SMTP id 4so7105091gxk.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 29 Jun 2009 18:36:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090629165133.GC1323@b07421-ec1.am.freescale.net>
References: <cb9ecdfa0906290858x125b8149na037f33258c21426@mail.gmail.com>
	<20090629165133.GC1323@b07421-ec1.am.freescale.net>
Date: Tue, 30 Jun 2009 09:36:51 +0800
Message-ID: <cb9ecdfa0906291836mf74c41fn9c187e305771920a@mail.gmail.com>
Subject: Re: PCI device support in Open Firmware (device tree syntax)
From: Johnny Hung <johnny.hacking@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: kernelnewbies@nl.linux.org, linuxppc-dev@lists.ozlabs.org,
	linux-embedded@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks for your reply. So there are no PCI device resource info in
flat device tree.
How do PCI device resources be assign in general case or is there any examp=
le?
I am so confusing, would you please give me detailed describle?

BRs, H. Johnny
>
> With flat device trees, PCI devices are not typically included as they
> can be probed instead. =A0Interrupt mapping is conveyed by the
> interrupt-map property in the PCI controller node.
>
> -Scott
>
