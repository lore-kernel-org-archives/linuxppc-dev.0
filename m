Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3DD7114007C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 May 2014 15:48:56 +1000 (EST)
Message-ID: <1399873724.17624.80.camel@pasglop>
Subject: Re: [PATCH] powerpc: Fix "attempt to move .org backwards" error
 (again)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 12 May 2014 15:48:44 +1000
In-Reply-To: <5370537F.8020901@roeck-us.net>
References: <1399680478-4970-1-git-send-email-linux@roeck-us.net>
 <1399867920.17624.73.camel@pasglop> <5370537F.8020901@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2014-05-11 at 21:52 -0700, Guenter Roeck wrote:
> Oh well, it was worth a try. Can you give me an example for a failing
> configuration ?

My g5 config which is close to g5_defconfig with PR KVM enabled.

In any case, see my other messages. I'm waiting for all my test builders
to come back and if it's clear I'll post a new patch.

Cheers,
Ben.
