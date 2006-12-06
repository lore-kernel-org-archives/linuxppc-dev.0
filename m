Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound6-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 29A7367BBE
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Dec 2006 14:00:58 +1100 (EST)
Message-ID: <45763263.80808@am.sony.com>
Date: Tue, 05 Dec 2006 19:00:51 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] cell: fix spu_info.h header export
References: <4575E712.5020103@am.sony.com> <200612052306.42632.arnd@arndb.de>
	<4575F092.8060604@am.sony.com> <200612052330.16986.arnd@arndb.de>
In-Reply-To: <200612052330.16986.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> It uses #ifdef __KERNEL__, so needs to be processes with unifdef
> 
> Signed-off-by: Arnd Bergann <arnd.bergmann@de.ibm.com>

Yes, this is the proper fix.

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
