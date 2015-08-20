Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 21D591A0226
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 19:26:59 +1000 (AEST)
Date: Thu, 20 Aug 2015 04:26:50 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: "Dominik 'Rathann' Mierzejewski" <dominik@greysector.net>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: error: 'asm' operand has impossible constraints when compiling
 gromacs 5.1 on PPC64 and PPC64LE with VSX SMD
Message-ID: <20150820092649.GD26407@gate.crashing.org>
References: <20150820073106.GB10057@sakura.greysector.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150820073106.GB10057@sakura.greysector.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Thu, Aug 20, 2015 at 09:31:07AM +0200, Dominik 'Rathann' Mierzejewski wrote:
> /builddir/build/BUILD/gromacs-5.1/src/gromacs/simd/impl_ibm_vsx/impl_ibm_vsx.h:452:80: error: 'asm' operand has impossible constraints
>      __asm__ ("xvcvsxwdp %0,%1" : "=ww" (x) : "ww" ((__vector signed int) (ix)));
>                                                                                 ^

Please file a bug report; see  http://gcc.gnu.org/bugs/  .
Thanks!

(Btw, you forgot the most important piece of information -- the GCC
version).

Segher
