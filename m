Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 628792C01FC
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jul 2013 17:40:27 +1000 (EST)
Message-ID: <1373269221.4446.32.camel@pasglop>
Subject: Re: [PATCH v2] powerpc: add real mode support for dma operations on
 powernv
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Mon, 08 Jul 2013 17:40:21 +1000
In-Reply-To: <51DA6AE6.9040201@ozlabs.ru>
References: <1373123227-22969-6-git-send-email-aik@ozlabs.ru>
 <1373258669-3130-1-git-send-email-aik@ozlabs.ru>
 <1373268055.4446.31.camel@pasglop> <51DA6AE6.9040201@ozlabs.ru>
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

On Mon, 2013-07-08 at 17:31 +1000, Alexey Kardashevskiy wrote:

> btw is phys_addr_t correct here?

Yes.

Cheers,
Ben.
