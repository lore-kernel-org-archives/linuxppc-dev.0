Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 75BB6DDF8F
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Feb 2007 03:35:28 +1100 (EST)
Message-ID: <45E30C3E.80006@am.sony.com>
Date: Mon, 26 Feb 2007 08:35:10 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] ps3: Introduce CONFIG_PS3_ADVANCED
References: <200702210946.27758.toralf.foerster@gmx.de>
	<Pine.LNX.4.62.0702211102000.340@pademelon.sonytel.be>
	<Pine.LNX.4.64.0702211238400.14457@scrub.home>
	<Pine.LNX.4.62.0702211322350.340@pademelon.sonytel.be>
	<Pine.LNX.4.64.0702220052020.14457@scrub.home>
	<Pine.LNX.4.62.0702221854520.25919@pademelon.sonytel.be>
	<Pine.LNX.4.64.0702232343330.14457@scrub.home>
	<Pine.LNX.4.62.0702261644310.5716@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0702261644310.5716@pademelon.sonytel.be>
Content-Type: text/plain; charset=UTF-8
Cc: Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>,
	=?UTF-8?B?77+9?= <toralf.foerster@gmx.de>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven wrote:
> ps3: Introduce CONFIG_PS3_ADVANCED, as suggested by Roman Zippel, and use it to
> control questions about PS3 subsystems that may not be obvious for the casual
> user.
> 
> This gets rid of the following warning on non-powerpc platforms:
> | drivers/video/Kconfig:1604:warning: 'select' used by config symbol 'FB_PS3' refer to undefined symbol 'PS3_PS3AV'

Please apply, fixes build warning in 2.6.21-rc1.

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
