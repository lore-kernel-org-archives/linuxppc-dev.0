Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 937AFDE140
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 23:10:12 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Subject: Re: [PATCH 2/2] celleb: split machine definition
Date: Thu, 13 Dec 2007 13:10:09 +0100
References: <20071213.191314.-1350525689.kouish@swc.toshiba.co.jp>
In-Reply-To: <20071213.191314.-1350525689.kouish@swc.toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712131310.09756.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 13 December 2007, Ishizaki Kou wrote:
> This patch splits machine definition for celleb into two definitoins,
> one is for celleb_beat, and another is for celleb_native. Though this
> patch looks complex because of sorting some functions, there are no
> more semantic changes than that for the splitting.

Looks good, thanks!

> Signed-off-by: Kou Ishizaki <Kou.Ishizaki@toshiba.co.jp>

Acked-by: Arnd Bergmann <arnd@arndb.de>
