Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 440BD67B6A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Oct 2006 11:47:05 +1000 (EST)
Subject: Re: status of mpc52xx with arch=powerpc?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <528646bc0610180652u2ee8e8b4xe25d555a59a27c85@mail.gmail.com>
References: <20061018130628.GE6202@localhost.localdomain>
	<528646bc0610180652u2ee8e8b4xe25d555a59a27c85@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 25 Oct 2006 11:46:55 +1000
Message-Id: <1161740815.22582.1.camel@localhost.localdomain>
Mime-Version: 1.0
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

On Wed, 2006-10-18 at 07:52 -0600, Grant Likely wrote:
> On 10/18/06, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > Is someone working on this already?
> >
> > There are some Kconfig entries, but there seems to be no code, at least
> > not in vanilla.
> 
> I'm slowly working on it.  I've got a .dts written and I've got u-boot
> w/ the fdt patches running on the board.  I need to port the 52xx PIC
> driver into arch/powerpc before I attempt to boot.

Can you send me your .dts ? The bplan folks are doing things for their
EFIKA board and I didn't manage to get them to open up publically their
device-tree until the firmware is final and in production :( But I've
got them to change a few things already, and I'd like to make sure
things are in sync.

Regarding devices, I want to move everything to of_platform_device. I
have some patches in progress to make those easier to work with. I'll
send something in the upcoming couple of days as it's all part of some
Cell related work for a new southbridge.

I'm trying to make sure the bplan stuff and whatever you guys come up
with don't conflict.

Ben.
