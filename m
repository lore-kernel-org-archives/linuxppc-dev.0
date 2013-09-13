Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4A0122C016F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Sep 2013 15:39:30 +1000 (EST)
Message-ID: <1379050758.4098.37.camel@pasglop>
Subject: Re: [PATCH] powerpc/pmac: Early debug output on screen on 64-bit macs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
Date: Fri, 13 Sep 2013 15:39:18 +1000
In-Reply-To: <20130913051029.GA5411@concordia>
References: <1374718352.6142.48.camel@pasglop>
 <1374720597.6142.49.camel@pasglop> <20130913051029.GA5411@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-09-13 at 15:10 +1000, Michael Ellerman wrote:
> Looks like you merged the version with #define DEBUG.
> 
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/kernel/setup_64.c#n13

Yes, it looks like I've been distracted, I'll remove it again (or you
can send a patch :-)

Cheers,
Ben.
