Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (unknown [195.144.244.147])
	by ozlabs.org (Postfix) with ESMTP id 461422BF07
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Dec 2004 05:30:33 +1100 (EST)
Date: Thu, 23 Dec 2004 21:04:33 +0300
From: Andrey Volkov <avolkov@varma-el.com>
Message-ID: <581835436.20041223210433@varma-el.com>
To: Clemens Koller <clemens.koller@anagramm.de>
In-Reply-To: <41B97BC7.3000200@anagramm.de>
References: <20041210015932.A3B692BDA0@ozlabs.org>
	<200412100845.14486.g.jaeger@sysgo.com> <41B97BC7.3000200@anagramm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: video card for Lite5200
Reply-To: Andrey Volkov <avolkov@varma-el.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Clemens,

Friday, December 10, 2004, 1:34:47 PM, you wrote:

> Yes, the Fujitsu Coral P should work also.
> I use a Silicon Motion Inc. SM501 Voyager GX PCI Demo Board right now
> which is supposed to work with all the embedded systems. You can get
> that board for about EUR 495.- in Germany.
> I am currently working on the framebuffer drivers for the Voyager on
> PPC. Things seem to make good progress, here (there is an image on 
> screen :-). There is also an Epson or Asilient solution for embedded
> systems, maybe you can check that also. YMMV

Could you send me your kernel .config file for SM501?
I try use it too, but kernel (2.6.10-rc2) always restarting,
I think I forget, as usually, something somewhere :(.

And, Clemens, how about PCI bug of MPC5200 and SM501 (PCI clock to
Signal Valid Delay)? Are you doing something with demo board? Or it
working ok from box?

-- 
Best regards,
 Andrey Volkov
