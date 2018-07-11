Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Qft360qVzF35J
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2018 23:24:11 +1000 (AEST)
In-Reply-To: <20180617124909.26828-1-j.neuschaefer@gmx.net>
To: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>,
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 linux-kernel@vger.kernel.org
Subject: Re: powerpc: wii: Remove outdated comment about memory fixups
Message-Id: <41Qft13C7HzB4MW@ozlabs.org>
Date: Wed, 11 Jul 2018 23:24:08 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2018-06-17 at 12:49:06 UTC, =?utf-8?q?Jonathan_Neusch=C3=A4fer?= wrote:
> The workaround has been removed. What stays is just code to find the
> memory hole so the BATs can be configured properly in the function below.
> 
> Fixes: 57deb8fea01f ("powerpc/wii: Don't rely on the reserved memory hack")
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8272f598523d0975259080d2f9d760

cheers
