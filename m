Return-Path: <rutger@wingding.demon.nl>
Received: from post-26.mail.nl.demon.net (post-26.mail.nl.demon.net
	[194.159.73.196]) by ozlabs.org (Postfix) with ESMTP id AA01B67BB2
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Nov 2006 06:06:13 +1100 (EST)
Date: Sun, 26 Nov 2006 20:06:09 +0100
From: Rutger Nijlunsing <rutger@nospam.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: powerpc.git build error
Message-ID: <20061126190609.GA20291@nospam.com>
References: <20061125225807.GA10510@nospam.com>
	<1164523183.10222.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1164523183.10222.1.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: linuxppc-dev@tux.tmfweb.nl
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Nov 26, 2006 at 05:39:43PM +1100, Michael Ellerman wrote:
> On Sat, 2006-11-25 at 23:58 +0100, Rutger Nijlunsing wrote:
[snip]
> >
> > This has undoubtly to do with my config (CONFIG_PPC64=n,
> > CONFIG_PPC32=y); .config attached for full inspection.
> 
> And CONFIG_KEXEC=y, which is not in any 32-bit defconfigs. Do you
> actually want it enabled?

Long story... I'm trying to get a completely working Lombard with all
of its features (PCMCIA wireless, suspend-to-RAM, etc.). However, this
failed. For example, currently I can only reboot into Linux with the
reset-button on the back: not very convenient. The symptons are that
it shuts down correctly, but pressing the power buttons sounds the
chime once and that's it. The screen stays blank. So I wanted to try
rebooting-with-kexec so I could try different kernels and find one
which worked completely. So, no, I don't want it enabled in a perfect
world. But we're not there yet :)

(currently setting PPC_EFIKA=y also breaks compiling, so I've disabled
it for now...)

> See my patch just posted which should fix this for you.

Thanks!

-- 
Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
