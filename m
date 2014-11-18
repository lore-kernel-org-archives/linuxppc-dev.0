Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0143.outbound.protection.outlook.com [157.56.111.143])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7FB4E1A0108
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 12:28:21 +1100 (AEDT)
Message-ID: <1416274083.15957.96.camel@freescale.com>
Subject: Re: [PATCH] i2c-qoriq: modified compatibility for correct prescaler
From: Scott Wood <scottwood@freescale.com>
To: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 17 Nov 2014 19:28:03 -0600
In-Reply-To: <20141114082832.GA2180@katana>
References: <1413538026-15739-1-git-send-email-valentin.longchamp@keymile.com>
 <1414537731.23458.120.camel@snotra.buserror.net>
 <5450AC85.40302@keymile.com> <20141113003418.GE2062@katana>
 <5465B285.7070005@keymile.com> <20141114082832.GA2180@katana>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Valentin Longchamp <valentin.longchamp@keymile.com>,
 Linux device trees <devicetree@vger.kernel.org>, "Boschung,
 Rainer" <Rainer.Boschung@keymile.com>, "Brunck,
 Holger" <Holger.Brunck@keymile.com>, Linux I2C <linux-i2c@vger.kernel.org>,
 Linux PowerPC Kernel <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-11-14 at 09:28 +0100, Wolfram Sang wrote:
> > > 
> > > If we're going to change the device tree I'd rather just add a property
> > > to say what the prescaler is.
> > 
> >  We would however, leave the boards' device trees that use things like
> > "fsl,mpc8543-i2c" as is and introduce the prescaler for the others requiring it.
> > 
> > 
> > Now the drawback is that the driver would require a change, to parse this
> > prescaler new prescaler property. Would this be OK from your point of view
> > Wolfram ? If yes, I will send the patches for it.
> 
> I don't think it is OK.

Why?

>  I'd think it can be deduced from the compatible property.

For almost all existing device trees it cannot be.

If you want something that will work without changing device trees,
you'll need to use SVR to identify the SoC.

-Scott
