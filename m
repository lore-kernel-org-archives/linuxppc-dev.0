Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ywyXR40H0zDqmD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Dec 2017 22:39:19 +1100 (AEDT)
In-Reply-To: <af9bcd9cdbc64f2c2638ba869979de003ba4671c.1477367819.git.joe@perches.com>
To: Joe Perches <joe@perches.com>, Anatolij Gustschin <agust@denx.de>,
 Scott Wood <oss@buserror.net>, Kumar Gala <galak@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Geoff Levand <geoff@infradead.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc: Use pr_warn instead of pr_warning
Message-Id: <3ywyXQ5lPJz9sBW@ozlabs.org>
Date: Tue, 12 Dec 2017 22:39:18 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-10-25 at 04:00:08 UTC, Joe Perches wrote:
> At some point, pr_warning will be removed so all logging messages use
> a consistent <prefix>_warn style.
> 
> Update arch/powerpc/
> 
> Miscellanea:
> 
> o Coalesce formats
> o Realign arguments
> o Use %s, __func__ instead of embedded function names
> o Remove unnecessary line continuations
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> Acked-by: Geoff Levand <geoff@infradead.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f2c2cbcc35d47f1471a04155ac3575

cheers
