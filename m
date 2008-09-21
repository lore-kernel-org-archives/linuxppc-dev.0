Return-Path: <jacmet@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by ozlabs.org (Postfix) with ESMTP id 2B600DDE31
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Sep 2008 04:43:26 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id e27so498329nfd.9
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Sep 2008 11:43:23 -0700 (PDT)
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: gpio driver for mpc831x/834x/837x with OF
	bindings
References: <1220627327-28852-1-git-send-email-jacmet@sunsite.dk>
	<8B2A3D71-C756-4281-8FF1-ADEC7861C630@kernel.crashing.org>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Sun, 21 Sep 2008 20:43:16 +0200
In-Reply-To: <8B2A3D71-C756-4281-8FF1-ADEC7861C630@kernel.crashing.org> (Kumar
	Gala's message of "Fri\, 19 Sep 2008 13\:10\:26 -0500")
Message-ID: <8763opz6ez.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Kumar" == Kumar Gala <galak@kernel.crashing.org> writes:

Hi,

 >> create mode 100644 arch/powerpc/sysdev/mpc83xx_gpio.c

 Kumar> So we need to make this mpc8xxx_gpio.c 83xx, 8610, 85xx all have the
 Kumar> same GPIO hw.

Ok.

I'm not really familiar with the other 8xxx SoCs, but from looking at
the reference manuals it seems like the following are compatible:

831x, 834x and 837x
8572 (but not the other 85xx)
8610 (but not the other 86xx)

Worth noting is also that mpc5121 seems to use a newer version of the
core which is basically backwards compatible (It has more IRQ trigger
possibilities).

I'll respind the patch with 83xx->8xxx - Do you still want to keep the OF
bindings like they are? (compatible = "fsl,mpc8349-gpio")

-- 
Bye, Peter Korsgaard
