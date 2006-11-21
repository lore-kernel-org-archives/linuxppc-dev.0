Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 956B567CA2
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 21:24:52 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC/PATCH 0/9] More xmon cell patches
Date: Tue, 21 Nov 2006 11:24:44 +0100
References: <1163661800.406227.631357998554.qpush@cradle>
In-Reply-To: <1163661800.406227.631357998554.qpush@cradle>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611211124.45158.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 16 November 2006 08:23, Michael Ellerman wrote:
> This is an updated series of xmon cell patches, it replaces the series
> of three I sent earlier (Nov 3rd).
> 
> It fixes the xmon sparse warnings, updates 'ss, adds 'sd' and 'sdi'
> commands to xmon - and incorporates updated disassembly code. Finally
> we make the disassembly optional for folks looking for a smaller kernel.

Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

All 9 patches look good to me. Paul, please include in powerpc.git.

	Arnd <><
