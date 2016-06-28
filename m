Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdyBx0gDyzDqnN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 17:30:32 +1000 (AEST)
Date: Tue, 28 Jun 2016 02:30:16 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: David Binderman <linuxdev.baldrick@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, dcb314@hotmail.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: arch/powerpc/xmon/dis-asm.h: 2 * wrong specifiers ?
Message-ID: <20160628073016.GH27655@gate.crashing.org>
References: <CAMzoama3BkAfxqzEt2khiPOcKxkOP1JVSx5UcCwWvGJLGrzLtA@mail.gmail.com>
 <1467086888.32607.9.camel@ellerman.id.au>
 <CAMzoambZ9wu3orkFfYemTQiMpf+OWPdk8v6_SXsJapS74HE13A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMzoambZ9wu3orkFfYemTQiMpf+OWPdk8v6_SXsJapS74HE13A@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 28, 2016 at 08:06:56AM +0100, David Binderman wrote:
> I think you can also get a similar warning if you tweek the gcc compiler warning
> flags. -Wformat=2 maybe.

-Wformat=1 (which is enabled by -Wall) already warns for this.

warning: format '%x' expects argument of type 'unsigned int', but argument 2 has type 'long unsigned int' [-Wformat=]


Segher
