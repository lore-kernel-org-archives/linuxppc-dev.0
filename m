Return-Path: <rutger@wingding.demon.nl>
Received: from post-26.mail.nl.demon.net (post-26.mail.nl.demon.net
	[194.159.73.196]) by ozlabs.org (Postfix) with ESMTP id B044D67C33
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Nov 2006 08:05:39 +1100 (EST)
Date: Sun, 26 Nov 2006 22:05:35 +0100
From: Rutger Nijlunsing <eludias@dse.nl>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: powerpc.git build error
Message-ID: <20061126210535.GA5639@nospam.com>
References: <20061125225807.GA10510@nospam.com>
	<1164523183.10222.1.camel@localhost.localdomain>
	<20061126190609.GA20291@nospam.com>
	<Pine.LNX.4.60.0611262144230.8431@poirot.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.60.0611262144230.8431@poirot.grange>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: eludias@dse.nl
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Nov 26, 2006 at 09:47:22PM +0100, Guennadi Liakhovetski wrote:
> On Sun, 26 Nov 2006, Rutger Nijlunsing wrote:
> 
> > Long story... I'm trying to get a completely working Lombard with all
> > of its features (PCMCIA wireless, suspend-to-RAM, etc.). However, this
> 
> I would be interested to hear if you manage to get suspend-to-ram and 
> kexec working! Are there any external patches available or you're just 
> starting to work on this? I'm also trying to do those (mostly str, kexec 
> just tried shortly, didn't work) on an embedded 8241 (G2 core).

Hold your horses, I'm just a simple user without too much
understanding of the hardware trying to get most out of his PowerBook
G3 Lombard (with broken L2 cache: 33bogomips) which I got a week ago :)

It seems suspend-to-ram is working to some extend, or at least
'should' work out-of-the-box. When I close the lid and reopen it, it
resumes 'a little': PCMCIA cards seem to power up again (TX/RX WiFi
led starts to flash again), but the screen stays dark. I haven't tried
to debug this yet, since getting WiFi to work

Furthermore I'm not interested in kexec if 'all is working'. But since
'rebooting' already hangs after the powerdown, I'm more focused on
getting the normal 'reboot' working.

Since you're using more esotoric hardware, I'm afraid it will be quite
difficult without getting your hands very dirty.

-- 
Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
