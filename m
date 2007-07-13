Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id C6DD3DDE02
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 19:56:32 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 0/5] Kconfig cleanup revisited
Date: Fri, 13 Jul 2007 11:54:34 +0200
References: <20070712210156.973038514@arndb.de>
	<20070713013953.GC29074@mag.az.mvista.com>
In-Reply-To: <20070713013953.GC29074@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707131154.34800.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 13 July 2007, Mark A. Greer wrote:
> I really like what you've done here, thanks.
> 
> The patches don't apply straight up so what other patches do these go
> on top of?

They are meant to apply on top of powerpc.git. I found now that
the first patch has a trivial reject against the for-2.6.23 branch,
but works fine for the master branch.

Should I resend?

	Arnd <><
