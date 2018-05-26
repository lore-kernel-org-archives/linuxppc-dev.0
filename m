Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40tXyT2lNfzF1gG
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 May 2018 05:20:32 +1000 (AEST)
Date: Sat, 26 May 2018 14:19:43 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Paul Menzel <pmenzel+linuxppc-dev@molgen.mpg.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: arch/powerpc/kernel/head_32.S:1106: Error: missing operand
Message-ID: <20180526191943.GR17342@gate.crashing.org>
References: <e015d6b2-79b8-e05d-5053-5ca0036679d3@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e015d6b2-79b8-e05d-5053-5ca0036679d3@molgen.mpg.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, May 26, 2018 at 06:35:34AM +0200, Paul Menzel wrote:
> Building the configuration created with `make tinyconfig` on the Power 8 
> system IBM S822LC with Ubuntu 18.04 fails with the error below.

>   AS      arch/powerpc/kernel/head_32.o
> arch/powerpc/kernel/head_32.S: Assembler messages:
> arch/powerpc/kernel/head_32.S:1106: Error: missing operand

You are building a 32-bit kernel for a 64-bit machine.  This is not
supported, and as you found out, does not work.


Segher
