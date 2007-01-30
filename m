Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 7AAC2DDE33
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 11:17:16 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 1/9] ps3: AV Settings Driver
Date: Tue, 30 Jan 2007 01:16:57 +0100
References: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
	<200701260513.24010.arnd@arndb.de>
	<Pine.LNX.4.62.0701291611300.19906@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0701291611300.19906@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701300116.57606.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, James Simmons <jsimmons@infradead.org>,
	Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 29 January 2007 16:14, Geert Uytterhoeven wrote:
> 
> > You should probably use the provided pr_debug or (better) dev_dbg
> > macros to do that now.
> 
> Except that it's difficult to get a struct device * in drivers/ps3/ps3av_cmd.c.
> And I prefer not to make ps3av_dev (which is currently static) global.

Ok, as I said, dev_dbg is the preferred way, but of course it only
works when you carry a device along. If you don't have one, use
pr_debug().

	Arnd <><
