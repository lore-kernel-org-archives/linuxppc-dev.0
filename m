Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id B98DEDDE08
	for <linuxppc-dev@ozlabs.org>; Sat, 17 May 2008 07:25:30 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id n7so401442wag.13
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 14:25:28 -0700 (PDT)
Message-ID: <9e4733910805161425i2d6cc034y3377af053a4198b5@mail.gmail.com>
Date: Fri, 16 May 2008 17:25:28 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 0/4] Describe SPI devices in the OF device tree and
	add mpc5200-spi driver
In-Reply-To: <fa686aa40805161348t52b94956w112ef6926ff30892@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<9e4733910805161327u4c42fd1dg5b09319d89db447c@mail.gmail.com>
	<fa686aa40805161348t52b94956w112ef6926ff30892@mail.gmail.com>
Cc: fabrizio.garetto@gmail.com, linuxppc-dev@ozlabs.org,
	dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 5/16/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Fri, May 16, 2008 at 2:27 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>  > On 5/16/08, Grant Likely <grant.likely@secretlab.ca> wrote:
>  >> This series is a set of changes to allow the slaves on an SPI bus to be
>  >>  described in the OF device tree (useful in arch/powerpc) and adds a driver
>  >>  that uses it (the Freescale MPC5200 SoC's SPI device).
>  >
>  > Right now we have SPI hooked up to PSC3. Hardware engineer is gone but
>  > I'll see if I can get him to alter things to use the SPI controller. I
>  > have an old mail from him where he thinks the Phytec board is missing
>  > a signal needed to use the SPI controller.
>
>
> While I'd appreciate the testing, I suspect that you really don't want
>  to do that.  The dedicated SPI controller isn't very good.  It only
>  does a byte at a time and so is rather slow.  A PSC is SPI mode should
>  be better (but I haven't tried it personally it yet).

What is the device tree node for PSC3 supposed to look like when it
has both serial and spi enabled?

-- 
Jon Smirl
jonsmirl@gmail.com
