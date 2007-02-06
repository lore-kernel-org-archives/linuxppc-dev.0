Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 6608ADDE3E
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 00:23:21 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/4] PS3: Move system bus to platform directory
Date: Tue, 6 Feb 2007 14:23:18 +0100
References: <45BFD2BB.1030008@am.sony.com>
In-Reply-To: <45BFD2BB.1030008@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702061423.18621.arnd@arndb.de>
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
> Move the PS3 system bus routines from drivers/ps3 to arch/powerpc/platforms/ps3.
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> 
Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
