Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 4B83DDEBB7
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 04:41:16 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] powerpc: add of_find_next_property andof_get_aliased_index
Date: Thu, 26 Jun 2008 20:41:12 +0200
References: <1214424332-18496-1-git-send-email-timur@freescale.com>
	<4863BBE2.2060107@freescale.com>
	<20080626142732.0ff6e64c@lappy.seanm.ca>
In-Reply-To: <20080626142732.0ff6e64c@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806262041.12275.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 26 June 2008, Sean MacLennan wrote:
> > Well, there's a lot of disagreement on this subject.  Not only do we
> > not agree on a method of enumerating devices, a lot of people have a
> > problem with the concept of enumerating them in the first place!
>
> An interesting point is that I enforced an index in the i2c-ibm_iic
> driver with no disagreement at all ;)

You have been lucky I suppose. :)

I could easily just have used this existing "index" property for the other 4xx 
boards, but expected NAK's for this. That and because FSL uses "cell-index" 
is why I asked prior to sending patches.

Now I have no idea how to support I2C on the other 4xx boards. Perhaps Josh 
could advise how this should be done?

Best regards,
Stefan
