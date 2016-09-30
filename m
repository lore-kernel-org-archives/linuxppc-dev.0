Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sm6my5TVpzDvHH
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Oct 2016 09:18:10 +1000 (AEST)
Message-ID: <1475277449.3784.47.camel@kernel.crashing.org>
Subject: Re: [PATCH 0/2] powerpc: stack protector (-fstack-protector) support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christophe LEROY <christophe.leroy@c-s.fr>, Denis Kirjanov
 <kda@linux-powerpc.org>
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Nicolas Pitre <nicolas.pitre@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Sat, 01 Oct 2016 09:17:29 +1000
In-Reply-To: <75290c3d-e2e8-52fc-043f-dcec645095f8@c-s.fr>
References: <cover.1475181427.git.christophe.leroy@c-s.fr>
 <CAOJe8K2bYSGe5ciY75eSbthkXNtQwJ2LBdgWcyqqo_jwhmoUsg@mail.gmail.com>
 <75290c3d-e2e8-52fc-043f-dcec645095f8@c-s.fr>
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

On Fri, 2016-09-30 at 18:38 +0200, Christophe LEROY wrote:
> I don't have any ppc64 target, I only have mpc8xx and mpc83xx which
> both 
> are ppc32

That's what qemu is for :-)

Cheers,
Ben.
