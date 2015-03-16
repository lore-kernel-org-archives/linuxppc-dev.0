Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 706C51A0163
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2015 11:08:18 +1100 (AEDT)
Message-ID: <1426464473.17565.223.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/2] powerpc: Add a proper syscall for switching endianness
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tony Breeds <tony@bakeyournoodle.com>
Date: Mon, 16 Mar 2015 11:07:53 +1100
In-Reply-To: <20150315225912.GA39518@thor.bakeyournoodle.com>
References: <1426221564-15086-1-git-send-email-mpe@ellerman.id.au>
 <1426228726.23806.3.camel@ellerman.id.au>
 <20150315225912.GA39518@thor.bakeyournoodle.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, Jeremy Kerr <jk@ozlabs.org>,
 Ian Munsie <imunsie@au1.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-03-16 at 09:59 +1100, Tony Breeds wrote:
> On Fri, Mar 13, 2015 at 05:38:46PM +1100, Michael Ellerman wrote:
> 
> > According to Paul there are no working implementations of LE on 32-bit cpus, so
> > the syscall doesn't really make sense there.
> 
> Ummm that doesn't sound right.  I don't think there is an LE linux userspace
> but I'm pretty sure we had 32-bit working on 44x.  Check where Ian did the
> initial LE patchset.

Yes but that's done by using a per-page endian flag, not a global MSR
bit, so we never supported a syscall to switch there and never will.

Cheers,
Ben.
