Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id C58E8DDDF7
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 19:17:00 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] [POWERPC] Wire up some more syscalls
Date: Mon, 14 May 2007 11:16:46 +0200
References: <20070514135033.07c1b840.sfr@canb.auug.org.au>
In-Reply-To: <20070514135033.07c1b840.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705141116.46592.arnd@arndb.de>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 14 May 2007, Stephen Rothwell wrote:
> This depends on the patch I just sent to declare compat_sys_signalfd and
> compat_sys_timerfd. =A0And I am assuming that the SPU's want these.

Yes, it's the right thing for SPUs.

signalfd might actually be important since we normally don't have a way
to get signals into an SPU, so some application programmers will love it.

	Arnd <><
