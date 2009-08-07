Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 653AFB6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 12:31:19 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AEC5EDDD0B
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2009 12:31:18 +1000 (EST)
Message-Id: <40E28EF5-215D-4D69-B44E-CD3145652F9B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: hs@denx.de
In-Reply-To: <4A769326.9090302@denx.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH v2 2/2] 82xx, mgcoge: update defconfig for 2.6.32
Date: Thu, 6 Aug 2009 21:31:03 -0500
References: <4A769326.9090302@denx.de>
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 3, 2009, at 2:35 AM, Heiko Schocher wrote:

> - add I2C support
> - add FCC1 and FCC2 support
>
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
> - against git://git.kernel.org/pub/scm/linux/kernel/git/benh/ 
> powerpc.git
>  next branch
> - checked with checkpatch.pl:
> $ ./scripts/checkpatch.pl 0002-82xx-mgcoge-update-defconfig- 
> for-2.6.32.patch
> total: 0 errors, 0 warnings, 381 lines checked

I had problems applying this to my 'next' branch

- k
