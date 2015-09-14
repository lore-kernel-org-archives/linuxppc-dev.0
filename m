Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4EDA21A2BFA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2015 15:19:48 +1000 (AEST)
Message-ID: <1442207986.8149.0.camel@ellerman.id.au>
Subject: Re: Build regressions/improvements in v4.3-rc1
From: Michael Ellerman <mpe@ellerman.id.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Stephen Rothwell
 <sfr@canb.auug.org.au>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 14 Sep 2015 15:19:46 +1000
In-Reply-To: <CAMuHMdVGEDKFxD7wf6ZOAGiOByM5c0Awx-anLsYGLQHV1yJW+w@mail.gmail.com>
References: <1442134868-17607-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdV31w=aDD-=uUPOqW71xLpOnH1jWeQpH=6x=vxNSo94FQ@mail.gmail.com>
 <20150913151926.GA19850@roeck-us.net>
 <CAMuHMdVGEDKFxD7wf6ZOAGiOByM5c0Awx-anLsYGLQHV1yJW+w@mail.gmail.com>
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

On Sun, 2015-09-13 at 22:23 +0200, Geert Uytterhoeven wrote:
> On Sun, Sep 13, 2015 at 5:19 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > arm64:allmodconfig:
> >
> > drivers/firmware/qcom_scm-32.c:196:4: error: expected string literal before ‘__asmeq’
> > drivers/firmware/qcom_scm-32.c:221:2: error: implicit declaration of function ‘secure_flush_area’
> > drivers/firmware/qcom_scm-32.c:239:2: error: implicit declaration of function ‘outer_inv_range’
> > drivers/firmware/qcom_scm-32.c:331:4: error: expected string literal before ‘__asmeq’
> > drivers/firmware/qcom_scm-32.c:361:4: error: expected string literal before ‘__asmeq’
> 
> Time for kisskb to gain arm64 support?

Yes. I'll add it to my TODO list.

cheers
