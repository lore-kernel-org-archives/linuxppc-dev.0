Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 4F274DDE10
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 19:05:41 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 4/7] Celleb: New HTAB Guest OS Interface on Beat
Date: Thu, 27 Sep 2007 10:51:58 +0200
References: <20070927.165326.-1300536104.kouish@swc.toshiba.co.jp>
In-Reply-To: <20070927.165326.-1300536104.kouish@swc.toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709271051.59180.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 27 September 2007, Ishizaki Kou wrote:
> This is a patch kit to work with new Guest OS Interface
> to tweak HTAB on Beat. It detects old and new Guest OS Interfaces
> automatically.
> 
> Signed-off-by: Kou Ishizaki <Kou.Ishizaki@toshiba.co.jp>

Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

The code looks good. One possible optimization I can imagine is
to split the v3 functions and the older versions into separate
source files, and then use configuration options to decide if
you want to build a kernel just for one of the two, or for
both variants. You could even have two separate machine descriptions,
while still sharing most of the platform code in common files.

	Arnd <><
