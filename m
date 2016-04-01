Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qblkV16V8zDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 13:31:30 +1100 (AEDT)
Message-ID: <1459477889.10334.1.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: ppc4xx: drop unused variable
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Alexandre
 Courbot <acourbot@nvidia.com>, Anatolij Gustschin <agust@denx.de>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>,  "linuxppc-dev@lists.ozlabs.org list"
 <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 01 Apr 2016 13:31:29 +1100
In-Reply-To: <CACRpkdbbUfbe6LWVDFsgvne7oOEp7ZzOKr9tX7y-P=J8g7c5=A@mail.gmail.com>
References: <1459408452-3483-1-git-send-email-linus.walleij@linaro.org>
 <1459418980.24848.1.camel@ellerman.id.au>
 <CACRpkdbbUfbe6LWVDFsgvne7oOEp7ZzOKr9tX7y-P=J8g7c5=A@mail.gmail.com>
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

On Thu, 2016-03-31 at 14:57 +0200, Linus Walleij wrote:
> On Thu, Mar 31, 2016 at 12:09 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> 
> > If you feel like cross building powerpc in future it should be as simple as:
> > 
> >  $ dnf install gcc-powerpc64-linux-gnu || apt-get install gcc-powerpc-linux-gnu
> >  $ make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- ...
> 
> Ah hm yeah I guess everyone "should", it's just that these days I
> mainly rely on Fenguang's kautobuild to do this job for me and
> get back with the result from a plethora of arches.

Sure. That makes sense for all the silly little architectures.

But for powerpc you should really cross compile.

..

:P

> Sometimes a buggy bit slips through the cracks though, sorry
> about that.

No stress.

cheers
