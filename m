Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D10452C0092
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Aug 2013 08:05:42 +1000 (EST)
Date: Sat, 24 Aug 2013 00:05:39 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v3 13/31] clk: wrap I/O access for improved portability
Message-ID: <20130824000539.5554cad8@crub>
In-Reply-To: <20130802223000.6450.97817@quantum>
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1374495298-22019-14-git-send-email-gsi@denx.de>
 <20130802223000.6450.97817@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 02 Aug 2013 15:30:00 -0700
Mike Turquette <mturquette@linaro.org> wrote:

> Quoting Gerhard Sittig (2013-07-22 05:14:40)
> > the common clock drivers were motivated/initiated by ARM development
> > and apparently assume little endian peripherals
> > 
> > wrap register/peripherals access in the common code (div, gate, mux)
> > in preparation of adding COMMON_CLK support for other platforms
> > 
> > Signed-off-by: Gerhard Sittig <gsi@denx.de>
> 
> I've taken this into clk-next for testing. regmap deserves investigation
> but I don't think your series should be blocked on that. We can always
> overhaul the basic clock primitives with regmap support later on if that
> makes sense.

Mike, I cannot see it in clk-next branch of
git://git.linaro.org/people/mturquette/linux.git

Can you please check? Or am I looking in the wrong place?

Thanks,
Anatolij
