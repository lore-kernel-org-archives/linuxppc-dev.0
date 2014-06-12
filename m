Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A3EC31A00D3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jun 2014 07:57:54 +1000 (EST)
Message-ID: <1402610268.14780.85.camel@pasglop>
Subject: Re: powerpc/ppc64: Allow allmodconfig to build (finally !)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 13 Jun 2014 07:57:48 +1000
In-Reply-To: <20140612122644.GA17249@roeck-us.net>
References: <1399874254.17624.85.camel@pasglop>
 <20140612122644.GA17249@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-06-12 at 05:26 -0700, Guenter Roeck wrote:
> what happened with this patch ?

Well it breaks with that binutils version of yours ... I'm trying to fix
it in a better way but it's a mess... still working on it.

Cheers,
Ben.
