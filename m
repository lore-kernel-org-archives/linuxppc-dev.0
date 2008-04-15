Return-Path: <super.firetwister@googlemail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id 752D9DE37E
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 07:50:58 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so743308uge.0
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 14:50:56 -0700 (PDT)
To: benh@kernel.crashing.org
Subject: Re: Get new_emac driver running on 405EP
Date: Tue, 15 Apr 2008 23:51:41 +0200
References: <6a6049b80804141038k77ac361cl11f50bc9d890c6a2@mail.gmail.com>
	<1208206961.6958.180.camel@pasglop>
In-Reply-To: <1208206961.6958.180.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804152351.42651.super.firetwister@gmail.com>
From: Markus Brunner <super.firetwister@googlemail.com>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 14 April 2008, Benjamin Herrenschmidt wrote:
> > 2) On the 405EP only the MDIO pin of the emac0 is pinned out, so both
> > phys have to be accessed through this one. This affectes the mdio
> > read/write functions.
>
> The later can easily be described in the device-tree as it's a fairly
> common setup.

mdio-device does the trick. This feature wasn't used by any other board in the 
kernel yet.

I made another error. I did mix up the order of the MAL irqs, so the irq 
handlers went mad. This was detected as a soft lock-up.

After correcting that both emacs are working on ppc405EP :).

Regards

Markus
