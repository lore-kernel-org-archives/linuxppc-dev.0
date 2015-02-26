Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2DD1E1A0007
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 10:05:25 +1100 (AEDT)
Date: Thu, 26 Feb 2015 15:05:22 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] Fix offset2lib issue for x86*, ARM*, PowerPC and MIPS
Message-Id: <20150226150522.1d0c035e631d4ea3aae924ec@linux-foundation.org>
In-Reply-To: <20150226230052.GN8656@n2100.arm.linux.org.uk>
References: <54EB735F.5030207@upv.es>
 <CAGXu5j+SBRcj+BGyxEwUzgKsB2fdzNiPY37Q=JTsf=-QbGwoGA@mail.gmail.com>
 <20150223205436.15133mg1kpyojyik@webmail.upv.es>
 <20150224073906.GA16422@gmail.com>
 <20150226143815.09386fe280c7bd8797048bb2@linux-foundation.org>
 <20150226230052.GN8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 Kees Cook <keescook@chromium.org>, "x86@kernel.org" <x86@kernel.org>,
 Hector Marco Gisbert <hecmargi@upv.es>, LKML <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
 ismael Ripoll <iripoll@upv.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 26 Feb 2015 23:00:52 +0000 Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Thu, Feb 26, 2015 at 02:38:15PM -0800, Andrew Morton wrote:
> > diff -puN arch/arm64/Kconfig~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix arch/arm64/Kconfig
> > --- a/arch/arm64/Kconfig~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix
> > +++ a/arch/arm64/Kconfig
> > @@ -1,4 +1,4 @@
> > -config ARM64
> > +qconfig ARM64
> 
> Is this a typo?

yup.  But the coffee's nice and strong.
