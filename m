Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A13182C00A2
 for <linuxppc-dev@ozlabs.org>; Tue,  3 Jul 2012 08:20:24 +1000 (EST)
Message-ID: <1341267617.2588.51.camel@pasglop>
Subject: Re: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Date: Tue, 03 Jul 2012 08:20:17 +1000
In-Reply-To: <20120702213828.133470@gmx.net>
References: <1341205059.2588.30.camel@pasglop> <20120702213828.133470@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-07-02 at 23:38 +0200, Gerhard Pircher wrote:
> 
> What about this fix:?
> 
> http://patchwork.ozlabs.org/patch/166346/
> 
> At least I can't see it in the log...

The module fix went in. The ftrace patch, well, it's untested and we
don't even know if we have a problem with mcount yet, so no, I haven't
merged it yet.

Cheers,
Ben.
