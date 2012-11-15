Return-Path: <grant.likely@secretlab.ca>
Received: from mail-we0-f170.google.com (mail-we0-f170.google.com
 [74.125.82.170])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C97B42C0417
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2012 02:58:22 +1100 (EST)
Received: by mail-we0-f170.google.com with SMTP id x10so623645wey.15
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2012 07:58:18 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] bindings: i2c: use consistent naming for i2c binding
 descriptions
To: Wolfram Sang <wolfram@the-dreams.de>, linux-i2c@vger.kernel.org
In-Reply-To: <1352827003-24287-1-git-send-email-wolfram@the-dreams.de>
References: <1352827003-24287-1-git-send-email-wolfram@the-dreams.de>
Date: Thu, 15 Nov 2012 15:58:14 +0000
Message-Id: <20121115155814.30AA83E194B@localhost>
Cc: devicetree-discuss@ozlabs.org, Wolfram Sang <wolfram@the-dreams.de>,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 Rob Herring <robherring2@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 13 Nov 2012 18:16:43 +0100, Wolfram Sang <wolfram@the-dreams.de> wrote:
> Filenames of devictree binding documentation seems to be arbitrary and
> for me it is unneeded hazzle to find the corresponding documentation for
> a specific driver.
> 
> Naming the description the same as the driver is a lot easier and makes
> sense to me since the driver defines the binding it understands.
> 
> Also, remove a reference in one source to the binding documentation, since path
> information easily gets stale.
> 
> Signed-off-by: Wolfram Sang <wolfram@the-dreams.de>
> Cc: Rob Herring <robherring2@gmail.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>

Applied, thanks.

g.
