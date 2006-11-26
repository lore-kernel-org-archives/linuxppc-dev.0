Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 82BA667C86
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Nov 2006 09:55:56 +1100 (EST)
Subject: Re: powerpc.git build error
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@tux.tmfweb.nl
In-Reply-To: <20061126190609.GA20291@nospam.com>
References: <20061125225807.GA10510@nospam.com>
	<1164523183.10222.1.camel@localhost.localdomain>
	<20061126190609.GA20291@nospam.com>
Content-Type: text/plain
Date: Mon, 27 Nov 2006 09:56:29 +1100
Message-Id: <1164581791.4773.26.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > And CONFIG_KEXEC=y, which is not in any 32-bit defconfigs. Do you
> > actually want it enabled?
> 
> Long story... I'm trying to get a completely working Lombard with all
> of its features (PCMCIA wireless, suspend-to-RAM, etc.). 

All of those things should be working pretty much out of the box on a
lombard ...

> However, this failed. For example, currently I can only reboot into Linux with the
> reset-button on the back: not very convenient. The symptons are that
> it shuts down correctly, but pressing the power buttons sounds the
> chime once and that's it. The screen stays blank.

Ugh ? Can you be more precise on what exact steps you are doing and what
the result is ? Also it might be worth wiping the PRAM clean...

>  So I wanted to try
> rebooting-with-kexec so I could try different kernels and find one
> which worked completely. So, no, I don't want it enabled in a perfect
> world. But we're not there yet :)

kexec is not supported currently for the pmac platform. There would be
quite a bit of work to get it working.

Ben.
