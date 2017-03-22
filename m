Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vp7b93zzyzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 23:02:13 +1100 (AEDT)
In-Reply-To: <20170320065522.14839-1-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>, keescook@chromium.org,
 re.emese@gmail.com, kernel-hardening@lists.openwall.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: gcc-plugins: update architecture list in documentation
Message-Id: <3vp7b938Gbz9s7j@ozlabs.org>
Date: Wed, 22 Mar 2017 23:02:13 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-03-20 at 06:55:22 UTC, Andrew Donnellan wrote:
> Commit 65c059bcaa73 ("powerpc: Enable support for GCC plugins") enabled GCC
> plugins on powerpc, but neglected to update the architecture list in the
> docs. Rectify this.
> 
> Fixes: 65c059bcaa73 ("powerpc: Enable support for GCC plugins")
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/cc638a488a5205713b51eabd047be6

cheers
