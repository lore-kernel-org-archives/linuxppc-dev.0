Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F0F6E1A08C8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jan 2016 19:37:13 +1100 (AEDT)
Message-ID: <1453451833.24910.6.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Enable VMX copy on PPC970 (G5)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 22 Jan 2016 19:37:13 +1100
In-Reply-To: <20160122080857.GA11095@gate.crashing.org>
References: <1453335927-17419-1-git-send-email-mpe@ellerman.id.au>
 <20160122080857.GA11095@gate.crashing.org>
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

On Fri, 2016-01-22 at 02:08 -0600, Segher Boessenkool wrote:
> On Thu, Jan 21, 2016 at 11:25:27AM +1100, Michael Ellerman wrote:
> > There's no reason I'm aware of that the VMX copy loop shouldn't work on
> > PPC970. And in fact it seems to boot and generally be happy.
> 
> But is it faster?

Well Anton wrote it, so of course it is. ;)

Will try and get some numbers.

cheers
