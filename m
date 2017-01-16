Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v2LYQ2TLpzDqRc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 04:57:45 +1100 (AEDT)
Message-ID: <1484589463.24294.2.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/icp-opal: Fix missing KVM case and harden replay
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <pmac@au1.ibm.com>
Date: Mon, 16 Jan 2017 11:57:43 -0600
In-Reply-To: <20170116160759.GA31332@localhost.localdomain>
References: <1484533171.11927.24.camel@kernel.crashing.org>
 <20170116160759.GA31332@localhost.localdomain>
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

On Mon, 2017-01-16 at 21:37 +0530, Balbir Singh wrote:
> ??
> 
> <snip>
> 
> > @@ -39,7 +40,2

Ah evolution bug ... fixed upstream but fix hasn't made it to Fedora
yet.

I'll attach in the meantime.

Cheers,
Ben.
