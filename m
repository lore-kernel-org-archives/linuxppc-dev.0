Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwQM76qtwzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 15:27:31 +1000 (AEST)
Message-ID: <1461821251.25861.4.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/mm: Always use STRICT_MM_TYPECHECKS
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org
Cc: linuxppc-dev@ozlabs.org, linux-mm@kvack.org, Paul Mackerras
 <paulus@samba.org>,  aneesh.kumar@linux.vnet.ibm.com
Date: Thu, 28 Apr 2016 15:27:31 +1000
In-Reply-To: <4231376.YDJ7xlGR0L@wuerfel>
References: <1461209879-15044-1-git-send-email-mpe@ellerman.id.au>
 <4231376.YDJ7xlGR0L@wuerfel>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-04-21 at 11:56 +0200, Arnd Bergmann wrote:
> On Thursday 21 April 2016 13:37:59 Michael Ellerman wrote:
> > Testing done by Paul Mackerras has shown that with a modern compiler
> > there is no negative effect on code generation from enabling
> > STRICT_MM_TYPECHECKS.
> > 
> > So remove the option, and always use the strict type definitions.
> > 
> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > 
> 
> I recently ran into the same thing on ARM and have checked the history
> on the symbol. It seems that some architectures cannot pass structures
> in registers as function arguments, but powerpc can, so it was never
> needed in the first place.

Thanks Arnd.

cheers
