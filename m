Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 7E53ADDDE5
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 19:57:55 +1100 (EST)
Date: Wed, 14 Feb 2007 09:57:46 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Thomas Meyer <thomas@m3y3r.de>
Subject: Re: undefined symbol 'PS3_PS3AV'
In-Reply-To: <45D2A835.7020606@m3y3r.de>
Message-ID: <Pine.LNX.4.62.0702140955130.17463@pademelon.sonytel.be>
References: <45D2A835.7020606@m3y3r.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 14 Feb 2007, Thomas Meyer wrote:
> with 93bbad8fe13a25dcf7f3bc628a71d1a7642ae61b:
> 
> drivers/video/Kconfig:1604:warning: 'select' used by config symbol 'FB_PS3'
> refer to undefined symbol 'PS3_PS3AV'

It's defined in arch/powerpc/platforms/ps3/Kconfig, which is sourced by
arch/powerpc/Kconfig only.

I don't know what's the best way to shut this up. Anyone with a suggestion?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
