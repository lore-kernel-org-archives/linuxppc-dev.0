Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BBA4B1A09F2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2015 23:00:25 +1100 (AEDT)
Message-ID: <1448020825.14769.3.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: wire up sys_mlock2
From: Michael Ellerman <mpe@ellerman.id.au>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@ozlabs.org
Date: Fri, 20 Nov 2015 23:00:25 +1100
In-Reply-To: <1447964589-4244-1-git-send-email-kda@linux-powerpc.org>
References: <1447964589-4244-1-git-send-email-kda@linux-powerpc.org>
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

On Thu, 2015-11-19 at 23:23 +0300, Denis Kirjanov wrote:

> Tested with tools/testing/selftests/vm/mlock2-tests
> both on ppc64 and ppc32

Actually I did this myself and it's been in my fixes branch (which is in
linux-next) for a few days. I just asked Linus to pull it.

cheers
