Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A7B3F67BB2
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Nov 2006 14:16:21 +1100 (EST)
Subject: Re: powerpc.git build error
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: eludias@dse.nl
In-Reply-To: <20061126210535.GA5639@nospam.com>
References: <20061125225807.GA10510@nospam.com>
	<1164523183.10222.1.camel@localhost.localdomain>
	<20061126190609.GA20291@nospam.com>
	<Pine.LNX.4.60.0611262144230.8431@poirot.grange>
	<20061126210535.GA5639@nospam.com>
Content-Type: text/plain
Date: Mon, 27 Nov 2006 14:16:04 +1100
Message-Id: <1164597365.22055.2.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Hold your horses, I'm just a simple user without too much
> understanding of the hardware trying to get most out of his PowerBook
> G3 Lombard (with broken L2 cache: 33bogomips) which I got a week ago :)

What makes you think it has a broken L2 cache ? The 33 bogomips are
totally unrelated, it's the timebase frequency. Bogomips are NOT a
benchmark and on the powerpc architecture, and not even related to the
processor speed at all (but to the frequency of the timebase input).

> It seems suspend-to-ram is working to some extend, or at least
> 'should' work out-of-the-box. When I close the lid and reopen it, it
> resumes 'a little': PCMCIA cards seem to power up again (TX/RX WiFi
> led starts to flash again), but the screen stays dark. I haven't tried
> to debug this yet, since getting WiFi to work

Does it work better without the PCMCIA card ? Is it properly going to
sleep (snoozing LED) ? Also make sure you are using the proper video
driver (atyfb on the lombard) and not booting with "novideo" or
"video=ofonly".

> Furthermore I'm not interested in kexec if 'all is working'. But since
> 'rebooting' already hangs after the powerdown, I'm more focused on
> getting the normal 'reboot' working.

That is the strange thing... does it reboot fine in MacOS ?

> Since you're using more esotoric hardware, I'm afraid it will be quite
> difficult without getting your hands very dirty.

Ben.
