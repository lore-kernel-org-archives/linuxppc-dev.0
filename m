Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A2490DDF1F
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jan 2007 11:40:55 +1100 (EST)
Subject: Re: [PATCH 0/19] Patches for Toshiba Cell reference set
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <200701120051.l0C0p3Xu017082@toshiba.co.jp>
References: <200701120051.l0C0p3Xu017082@toshiba.co.jp>
Content-Type: text/plain
Date: Thu, 18 Jan 2007 11:41:13 +1100
Message-Id: <1169080873.4965.33.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-01-12 at 09:51 +0900, Ishizaki Kou wrote:
> Paul-san,
> 
> This is a revised version of the patch set for Toshiba Cell reference
> set (aka Celleb).
> 
> Patch 1-3 are generic for Cell and not dependent on any other patches.
> I think that they are useful for other platforms. Patch 4-19 are to
> support for Celleb.
> 
> This patch set is intended to be merged to 2.6.21.
> If you have any comment, please write to me.

Looks good. I did a few fairly minor comments. I'll let Arnd ack (or
not) the SPU related bits though.

Ben.
