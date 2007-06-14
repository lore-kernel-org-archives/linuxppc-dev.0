Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 172A2DDEC1
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 09:43:58 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 05/30 v2] PS3: Use ioremap_flags
Date: Fri, 15 Jun 2007 01:43:29 +0200
References: <20070612181825.730300780@am.sony.com> <466EE965.404@am.sony.com>
	<467190F4.4000307@am.sony.com>
In-Reply-To: <467190F4.4000307@am.sony.com>
MIME-Version: 1.0
Message-Id: <200706150143.29765.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: Masato Noguchi <Masato.Noguchi@jp.sony.com>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 14 June 2007, Geoff Levand wrote:
> Use ioremap_flags() to map SPU and htab regions as non-guarded.
> Change the use of _ioremap() to ioremap_flags().
> 
> CC: Arnd Bergmann <arnd.bergmann@de.ibm.com>
> CC: Masato Noguchi <Masato.Noguchi@jp.sony.com>
> CC: Takao Shinohara <shin@sm.sony.co.jp>
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
