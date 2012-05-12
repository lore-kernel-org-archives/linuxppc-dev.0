Return-Path: <grant.likely@secretlab.ca>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
 [209.85.210.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0D132B6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 May 2012 10:09:01 +1000 (EST)
Received: by dajt11 with SMTP id t11so4934663daj.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2012 17:08:59 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] gpiolib/arches: Centralise bolierplate asm/gpio.h
To: Mark Brown <broonie@opensource.wolfsonmicro.com>,
 Linus Walleij <linus.walleij@linaro.org>
In-Reply-To: <20120416081532.GA3238@opensource.wolfsonmicro.com>
References: <1334483574-3997-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CACRpkdZ8yH1ZSG-nQ9dLm0TipHS-jZDuxwqohUC=LGH9V-5q4w@mail.gmail.com>
 <20120416081532.GA3238@opensource.wolfsonmicro.com>
Date: Fri, 11 May 2012 18:08:53 -0600
Message-Id: <20120512000853.A96353E0791@localhost>
Cc: linux-arch@vger.kernel.org, Grant Likely <grant@secretlab.ca>,
 linux-ia64@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>,
 Chris Zankel <chris@zankel.net>, microblaze-uclinux@itee.uq.edu.au,
 linux@lists.openrisc.net, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 16 Apr 2012 09:15:32 +0100, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Apr 16, 2012 at 09:21:58AM +0200, Linus Walleij wrote:
> 
> > This looks good but I think we need to page the alpha, ia64, m68k, microblaze,
> > openrisc etc subarch maintainers on this patch so they have their say.
> 
> That's why I CCed linux-arch, to get all the architecture maintainers
> included.  vger would get upset if I CCed everyone individually.

Meh; it's been long enough.  I'll build the major ones and then throw it into linux-next.

g.

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
