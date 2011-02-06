Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D89B6B7110
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  7 Feb 2011 10:15:41 +1100 (EST)
Subject: Re: [PATCH -mm 2/6] powerpc: convert little-endian bitops macros
	to static inline functions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
In-Reply-To: <1296136583-13815-3-git-send-email-akinobu.mita@gmail.com>
References: <1296136583-13815-1-git-send-email-akinobu.mita@gmail.com>
	<1296136583-13815-3-git-send-email-akinobu.mita@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 07 Feb 2011 10:14:46 +1100
Message-ID: <1297034086.14982.8.camel@pasglop>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	akpm@linux-foundation.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-01-27 at 22:56 +0900, Akinobu Mita wrote:
> (This patch is intended to be folded into the patch in -mm:
> powerpc-introduce-little-endian-bitops.patch)
> 
> The little-endian bitops on powerpc are written as preprocessor
> macros with the cast to "unsigned long *".
> This means that even non-pointers will be accepted without an error, and
> that is a Very Bad Thing.
> 
> This converts the little-endian bitops macros to static inline functions
> with proper prototypes.

No objection to the powerpc variant of the patches. What is the status
with the wholes series tho ? Does it looks like its going to be
accepted ? Do you expect my Ack and will merge the whole thing at once ?
Does it break bisection unless it's merged as one single giant patch ?

Cheers,
Ben.
