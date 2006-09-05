Return-Path: <mgreer@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 09F7E67B88
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Sep 2006 04:48:43 +1000 (EST)
Date: Tue, 5 Sep 2006 11:49:08 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: Serial problem with MPC8241-based board
Message-ID: <20060905184908.GD28148@mag.az.mvista.com>
References: <44FAF68F.1080206@uid0.hu>
	<Pine.LNX.4.60.0609032112260.3944@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.60.0609032112260.3944@poirot.grange>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, Sep 03, 2006 at 09:58:25PM +0200, Guennadi Liakhovetski wrote:

Hi Guennadi,

> Mark, may I use this opportunity to ask you for your current consistent 
> snapshot of both powerpc/boot and powerpc/platforms and whatever others? I 
> can compile a kernel with ARCH=powerpc for linkstation, now I have to find 
> a way to boot it. My choices are kexec or u-boot. Neither will run 
> out-of-the-box, so...

I'm in the middle of making a bunch of changes to the bootwrapper
patches so I don't have a good set of patches for you.
Hopefully in a day or two at which time I'll be happy to share them with you.

> BTW, I would be greatful for any help with setting up kexec.

I can't help you there.  You could try asking Milton Miller.

Mark
