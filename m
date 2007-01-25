Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 0AA00DE023
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 16:59:32 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 4/14] ps3: fix struct alignment attributes
Date: Thu, 25 Jan 2007 06:59:22 +0100
References: <45B8187B.3010506@am.sony.com>
In-Reply-To: <45B8187B.3010506@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701250659.22727.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 25 January 2007 03:39, Geoff Levand wrote:
> Remove incorrect alignment attributes in PS3 platform code for
> struct spe_shadow, struct os_area_header, and struct os_area_params.
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> 
Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
