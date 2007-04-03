Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 2D08EDE049
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 03:20:24 +1000 (EST)
Date: Tue, 3 Apr 2007 12:36:31 -0500
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 01/17] [POWERPC] Rename get_property to of_get_property:
	include
Message-ID: <20070403173631.GA4844@lixom.net>
References: <20070403105217.7b9fea08.sfr@canb.auug.org.au>
	<20070403105401.1fcdee27.sfr@canb.auug.org.au>
	<20070403105539.7222cf2a.sfr@canb.auug.org.au>
	<20070403105650.204003b6.sfr@canb.auug.org.au>
	<20070403105748.769f156c.sfr@canb.auug.org.au>
	<20070403105852.7c7bfaa0.sfr@canb.auug.org.au>
	<20070403222406.cf39c459.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070403222406.cf39c459.sfr@canb.auug.org.au>
From: olof@lixom.net (Olof Johansson)
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 03, 2007 at 10:24:06PM +1000, Stephen Rothwell wrote:
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  include/asm-powerpc/parport.h |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> This set of patches follows the previous 6.  The whole lot have been
> built with allmodconfig on PowerPC64.

Why split this up in 17 patches? It's just a search and replace, might
as well do it as one patch. I don't think there's much use in being able
to bisect halfway through it.


-Olof
