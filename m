Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5126C2C0123
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Apr 2013 06:54:56 +1000 (EST)
Message-ID: <1366750477.12131.9.camel@pasglop>
Subject: Re: [PATCH v3 1/12] Create a powerpc update_devicetree interface
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Wed, 24 Apr 2013 06:54:37 +1000
In-Reply-To: <5176D715.4060606@linux.vnet.ibm.com>
References: <51757951.2080007@linux.vnet.ibm.com>
 <517581D4.7020104@linux.vnet.ibm.com> <1366676147.2886.2.camel@pasglop>
 <5176D715.4060606@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-04-23 at 13:46 -0500, Nathan Fontenot wrote:
> ok, good. I was not crazy about using ppc_md to do this and if you're fine
> with putting the pseries specific stuff in ifdef CONFIG_PPC_PSERIES I'll
> update the code to do that.
> 
> Question concerning rtas code. There is quite a bit of pseries specific 
> pieces in the general powerpc/kernel directory. Has there been, or should
> there be, any effort to move that to the pseries directory?

It's a good question ... it's shared in part with CHRP, it might make
sense to split it but only if the split can be done cleanly, which I
haven't looked into.

Cheers,
Ben.
