Return-Path: <mturquette@linaro.org>
Received: from mail-pb0-f53.google.com (mail-pb0-f53.google.com
 [209.85.160.53])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9851C2C0095
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2013 10:55:36 +1000 (EST)
Received: by mail-pb0-f53.google.com with SMTP id up15so5517850pbc.40
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2013 17:55:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Anatolij Gustschin <agust@denx.de>, 
From: Mike Turquette <mturquette@linaro.org>
In-Reply-To: <20130824000539.5554cad8@crub>
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1374495298-22019-14-git-send-email-gsi@denx.de>
 <20130802223000.6450.97817@quantum> <20130824000539.5554cad8@crub>
Message-ID: <20130828005528.8231.80079@quantum>
Subject: Re: [PATCH v3 13/31] clk: wrap I/O access for improved portability
Date: Tue, 27 Aug 2013 17:55:28 -0700
Cc: Gerhard Sittig <gsi@denx.de>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Quoting Anatolij Gustschin (2013-08-23 15:05:39)
> On Fri, 02 Aug 2013 15:30:00 -0700
> Mike Turquette <mturquette@linaro.org> wrote:
> =

> > Quoting Gerhard Sittig (2013-07-22 05:14:40)
> > > the common clock drivers were motivated/initiated by ARM development
> > > and apparently assume little endian peripherals
> > > =

> > > wrap register/peripherals access in the common code (div, gate, mux)
> > > in preparation of adding COMMON_CLK support for other platforms
> > > =

> > > Signed-off-by: Gerhard Sittig <gsi@denx.de>
> > =

> > I've taken this into clk-next for testing. regmap deserves investigation
> > but I don't think your series should be blocked on that. We can always
> > overhaul the basic clock primitives with regmap support later on if that
> > makes sense.
> =

> Mike, I cannot see it in clk-next branch of
> git://git.linaro.org/people/mturquette/linux.git
> =

> Can you please check? Or am I looking in the wrong place?

You were looking in the right place but I had not pushed out the latest
patches from my local branch. It should be there now.

Regards,
Mike

> =

> Thanks,
> Anatolij
