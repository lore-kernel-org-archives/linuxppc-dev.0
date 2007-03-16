Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound8-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8610ADDDE7
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 11:43:14 +1100 (EST)
Message-ID: <45F9E81C.5050407@am.sony.com>
Date: Thu, 15 Mar 2007 17:43:08 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: RFC: arch/powerpc Kconfig cleanup
References: <Pine.LNX.4.64.0703151816370.3448@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0703151816370.3448@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> One think I noticed is that various platforms/*/Kconfig create top level
> menu choices for things like:
> 
> PS3 Platform Options

The PS3 Kconfigs need a complete cleanup, but I haven't had a chance to do
it yet.

-Geoff
