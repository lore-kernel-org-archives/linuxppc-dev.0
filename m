Return-Path: <ruscur@russell.cc>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVdRK0xGMzDqlM
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 14:32:29 +1100 (AEDT)
Message-ID: <1509939132.2606.0.camel@russell.cc>
Subject: Re: [PATCH] powerpc: eeh: stop using do_gettimeofday()
From: Russell Currey <ruscur@russell.cc>
To: Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>
Cc: y2038@lists.linaro.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Andrew
 Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Mon, 06 Nov 2017 14:32:12 +1100
In-Reply-To: <20171104212727.3228606-1-arnd@arndb.de>
References: <20171104212727.3228606-1-arnd@arndb.de>
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

On Sat, 2017-11-04 at 22:26 +0100, Arnd Bergmann wrote:
> This interface is inefficient and deprecated because of the y2038
> overflow.
> 
> ktime_get_seconds() is an appropriate replacement here, since it
> has sufficient granularity but is more efficient and uses monotonic
> time.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Russell Currey <ruscur@russell.cc>
