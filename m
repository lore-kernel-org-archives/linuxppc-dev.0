Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rG12g0pBLzDqVr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 06:29:14 +1000 (AEST)
Date: Thu, 26 May 2016 15:28:56 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Rama Chandra <pc.ramachandra@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, eldk@lists.denx.de
Subject: Re: how to change bss section address in u-boot.lds file
Message-ID: <20160526202856.GA3907@gate.crashing.org>
References: <CA+Wf0EH_c3fPO-W9HU8fSoW3MXquFgEDza5jP0DsyR-0a3xd3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+Wf0EH_c3fPO-W9HU8fSoW3MXquFgEDza5jP0DsyR-0a3xd3g@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 26, 2016 at 05:31:08PM +0530, Rama Chandra wrote:
> Hai,
> I am using IBM PPC440GX board.In arch/powerpc/cpu/ppc4xx/u-boot.lds i am
> changing the values of resetvector and BSS addresses but it is not changing
> Presently i am changed
> 
> 
> #if (RESET_VECTOR_ADDRESS == 0xfffffff0)
>   . |= 44780000;

It looks like you forgot "0x" here.


Segher
