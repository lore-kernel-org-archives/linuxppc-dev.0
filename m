Return-Path: <lethal@linux-sh.org>
Received: from smtp.ocgnet.org (smtp.ocgnet.org [64.20.243.3])
	by ozlabs.org (Postfix) with ESMTP id 0A710DDEC3
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 20:09:11 +1100 (EST)
Date: Wed, 14 Feb 2007 18:07:01 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: undefined symbol 'PS3_PS3AV'
Message-ID: <20070214090701.GA11088@linux-sh.org>
References: <45D2A835.7020606@m3y3r.de>
	<Pine.LNX.4.62.0702140955130.17463@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.62.0702140955130.17463@pademelon.sonytel.be>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Thomas Meyer <thomas@m3y3r.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 14, 2007 at 09:57:46AM +0100, Geert Uytterhoeven wrote:
> On Wed, 14 Feb 2007, Thomas Meyer wrote:
> > with 93bbad8fe13a25dcf7f3bc628a71d1a7642ae61b:
> > 
> > drivers/video/Kconfig:1604:warning: 'select' used by config symbol 'FB_PS3'
> > refer to undefined symbol 'PS3_PS3AV'
> 
> It's defined in arch/powerpc/platforms/ps3/Kconfig, which is sourced by
> arch/powerpc/Kconfig only.
> 
> I don't know what's the best way to shut this up. Anyone with a suggestion?
> 
This would seem like a reasonable candidate for a 'depends on' instead of
a select..
