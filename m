Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zPxr76BcCzF0X1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 14:34:31 +1100 (AEDT)
In-Reply-To: <20180116170220.2598520-1-arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [RESEND] powerpc: mpic_timer: avoid struct timeval
Message-Id: <3zPxr35SGvz9sBW@ozlabs.org>
Date: Mon, 22 Jan 2018 14:34:26 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-01-16 at 17:01:50 UTC, Arnd Bergmann wrote:
> In an effort to remove all instances of 'struct timeval'
> from the kernel, I'm changing the powerpc mpic_timer interface
> to use plain seconds instead. There is only one user of this
> interface, and that doesn't use the microseconds portion, so
> the code gets noticeably simpler in the process.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/11ed8c5569b149a065184dc8ce2241

cheers
