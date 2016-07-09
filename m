Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rmjJ32jlRzDqpk
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Jul 2016 17:13:23 +1000 (AEST)
Message-ID: <1468048382.32358.81.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Sat, 09 Jul 2016 02:13:02 -0500
In-Reply-To: <3257f244fea7785aa1791d3ac68922692bffc3c3.1463486314.git.christophe.leroy@c-s.fr>
References: <3257f244fea7785aa1791d3ac68922692bffc3c3.1463486314.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH v3 2/2] powerpc32: fix check_io_access()
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-05-17 at 14:01 +0200, Christophe Leroy wrote:
> On processors like the 8xx, the machine check exception can also
> happen directly on the load/store instruction itself, so that case
> needs to be handled as well
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---

What machine checks are happening that this is handling?  Is there still 8xx
code that probes for registers that might not be there?

-Scott
