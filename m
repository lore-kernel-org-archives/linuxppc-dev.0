Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id F10A7DDEC9
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 18:43:36 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/4] PS3: Fix DMA scatter-gather
Date: Wed, 7 Feb 2007 08:43:24 +0100
References: <45BFD2C2.70000@am.sony.com>
In-Reply-To: <45BFD2C2.70000@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702070843.25255.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 31 January 2007 00:20, Geoff Levand wrote:
> Add the missing pieces to support DMA scatter-gather on the PS3 system bus.
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> 
Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
