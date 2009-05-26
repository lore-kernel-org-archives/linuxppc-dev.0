Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 434F8DE018
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 22:49:59 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH V4 1/5] The macro spin_event_timeout() takes a condition
	and timeout value
Date: Tue, 26 May 2009 13:49:48 +0100
References: <20090525221406.21370.30326.stgit@terra>
	<ed82fe3e0905260432xdc9556cp74edc723eafe24f7@mail.gmail.com>
	<alpine.LRH.2.00.0905261348160.4897@vixen.sonytel.be>
In-Reply-To: <alpine.LRH.2.00.0905261348160.4897@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <200905261349.49832.arnd@arndb.de>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>,
	broonie@sirena.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 26 May 2009, Geert Uytterhoeven wrote:
> However, you can still improve useability by making the macro return the rc,
> instead of letting the caller pass it, cfr. wait_event_timeout() and friends.

Either that, or it should at least use the do { ... } while (0) construct
to make the macro a statement. All multi-line macros need to either
use ({ ... }) or do { ... } while (0) to make sure they behave well.

	Arnd <><
