Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 716E62C01AB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 09:31:19 +1000 (EST)
Message-ID: <1375831851.12557.74.camel@pasglop>
Subject: Re: [PATCH V2 5/6] cpuidle/powerpc: Backend-powerpc idle driver for
 powernv and pseries.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Wed, 07 Aug 2013 09:30:51 +1000
In-Reply-To: <1375830520.5600.23.camel@snotra.buserror.net>
References: <20130731025840.19448.24468.stgit@deepthi>
 <20130731025934.19448.16658.stgit@deepthi>
 <1375830520.5600.23.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>, linux-pm@vger.kernel.org,
 daniel.lezcano@linaro.org, rjw@sisk.pl, linux-kernel@vger.kernel.org,
 dongsheng.wang@freescale.com, srivatsa.bhat@linux.vnet.ibm.com,
 preeti@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-08-06 at 18:08 -0500, Scott Wood wrote:
> Here's another example.  get_lppaca() will only build on book3s -- and
> yet we get requests for e500 code to use this file.

Indeed, Besides there is already accessors afaik for lppaca that compile
to nothing on E (and if not they would be trivial to add).

Cheers,
Ben.
