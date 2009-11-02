Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id 341D2B7C1B
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Nov 2009 03:37:49 +1100 (EST)
Received: by yxe8 with SMTP id 8so5326130yxe.17
	for <linuxppc-dev@ozlabs.org>; Mon, 02 Nov 2009 08:37:48 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20091102142232.GD4696@pengutronix.de>
References: <1256894234-11264-1-git-send-email-w.sang@pengutronix.de>
	<1256939657.6372.81.camel@pasglop>
	<20091031130131.GA23009@pengutronix.de>
	<1257022082.7907.7.camel@pasglop>
	<20091102142232.GD4696@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 2 Nov 2009 09:37:28 -0700
Message-ID: <fa686aa40911020837g78339e06rf8c1679b2d94c895@mail.gmail.com>
Subject: Re: mpc512x/clock: fix clk_get logic
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Wolfgang Denk <wd@denx.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 2, 2009 at 7:22 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
>> Sure I don't have major objections against your patch (though who is
>> formally mpc512x maintainer to ack it ?),
>
> Grant is maintainer for MPC5xxx.

Is this patch intended for mainline?  I've received so many 5121
patches that only apply against a Denx tree that I'm starting to
ignore them.  Until the bulk of the out-of-tree 5121 support is
merged, it would be helpful to specifically mention in the patch
description whether or not it should be merged upstream.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
