Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdP2Q0jQJzDqXv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 22:37:34 +1000 (AEST)
In-Reply-To: <20170821151651.25096-2-robh@kernel.org>
To: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 Scott Wood <oss@buserror.net>, David Laight <David.Laight@aculab.com>,
 Paul Mackerras <paulus@samba.org>, Anatolij Gustschin <agust@denx.de>,
 Frank Rowand <frowand.list@gmail.com>
Subject: Re: [v2,1/5] powerpc: Convert to using %pOF instead of full_name
Message-Id: <3xdP2P6YKjz9sRq@ozlabs.org>
Date: Thu, 24 Aug 2017 22:37:33 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-08-21 at 15:16:47 UTC, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Anatolij Gustschin <agust@denx.de>
> Cc: Scott Wood <oss@buserror.net>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linuxppc-dev@lists.ozlabs.org
> Reviewed-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b7c670d673d1186e9a6aafaad36aac


I forgot to add in the change log I took the chance to reformat some of the
affected printks, hopefully that doesn't muck you up when you're
merging/rebasing on top of this.

cheers
