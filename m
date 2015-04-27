Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8415D1A05AC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 04:23:31 +1000 (AEST)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
 (envelope-from <linux@roeck-us.net>) id 1Ymngm-001IVC-Vb
 for linuxppc-dev@lists.ozlabs.org; Mon, 27 Apr 2015 18:23:29 +0000
Date: Mon, 27 Apr 2015 11:23:11 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Build regressions/improvements in v4.1-rc1
Message-ID: <20150427182311.GA10136@roeck-us.net>
References: <1430128286-8952-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdWoUPZ92GX9fe8eq87buLQOT9GMb6Ru3_bQJpkZTFph0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMuHMdWoUPZ92GX9fe8eq87buLQOT9GMb6Ru3_bQJpkZTFph0g@mail.gmail.com>
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>, MarkBrown@roeck-us.net,
 Rusty Russell <rusty@rustcorp.com.au>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 sparclinux <sparclinux@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 27, 2015 at 12:03:32PM +0200, Geert Uytterhoeven wrote:
> On Mon, Apr 27, 2015 at 11:51 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > Below is the list of build error/warning regressions/improvements in
> > v4.1-rc1[1] compared to v4.0[2].
> >
> > Summarized:
> >   - build errors: +34/-11
> >   - build warnings: +135/-163
> >
> > As I haven't mastered kup yet, there's no verbose summary at
> > http://www.kernel.org/pub/linux/kernel/people/geert/linux-log/v4.1-rc1.summary.gz
> >
> > Happy fixing! ;-)
> >
> > Thanks to the linux-next team for providing the build service.
> >
> > [1] http://kisskb.ellerman.id.au/kisskb/head/8779/ (254 out of 257 configs)
> > [2] http://kisskb.ellerman.id.au/kisskb/head/8710/ (254 out of 257 configs)
> >
> >
> > *** ERRORS ***
> >
> > 34 regressions:
> 
> The quiet days are over...
> 
Is it just my impression, or is the code quality in this commit window
a bit lower than usual (very politely said) ?

Guenter
