Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tQK3z4KLGzDvww
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Nov 2016 01:59:43 +1100 (AEDT)
Date: Fri, 25 Nov 2016 08:59:24 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Oliver O'Halloran" <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Nicholas Piggin <npiggin@gmail.com>, Alan Modra <amodra@gmail.com>
Subject: Re: [RFC][PATCH] powerpc/64be: use ELFv2 ABI for big endian kernels
Message-ID: <20161125145923.GA32415@gate.crashing.org>
References: <20161123130840.1877-1-npiggin@gmail.com>
 <20161123143834.GB6099@gate.crashing.org>
 <CAOSf1CEJwdCCPVcksOBUSut_fPbr6WizacRrFRgMAJAeWoCqRw@mail.gmail.com>
 <20161124122713.GC14394@gate.crashing.org>
 <87d1hktt5z.fsf@concordia.ellerman.id.au>
 <20161124231716.GB30675@gate.crashing.org>
 <877f7stiy5.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <877f7stiy5.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 25, 2016 at 01:02:58PM +1100, Michael Ellerman wrote:
> Because we're hairy chested kernel programmers we don't actually build a
> C library at all. So we don't get that hint that we're using an odd
> combination, we just configure the toolchain, build it and off we go.

Right, I keep forgetting that kernel developers never read any
documentation either :-P


Segher
