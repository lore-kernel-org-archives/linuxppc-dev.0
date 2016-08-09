Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7cZ84CCkzDqTq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 11:46:08 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Guenter Roeck <linux@roeck-us.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
 Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH] powerpc: vdso: Add missing include file
In-Reply-To: <1470524052-27133-1-git-send-email-linux@roeck-us.net>
References: <1470524052-27133-1-git-send-email-linux@roeck-us.net>
Date: Tue, 09 Aug 2016 11:46:07 +1000
Message-ID: <877fbqsoio.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Guenter Roeck <linux@roeck-us.net> writes:

> Some powerpc builds fail with the following buld error.

Is that a randconfig?

All my builds are green.

Thanks for the patch anyway.

cheers
