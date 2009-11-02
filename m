Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f199.google.com (mail-yw0-f199.google.com
	[209.85.211.199]) by ozlabs.org (Postfix) with ESMTP id D05ACB7BFA
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Nov 2009 08:14:06 +1100 (EST)
Received: by ywh37 with SMTP id 37so5573766ywh.17
	for <linuxppc-dev@ozlabs.org>; Mon, 02 Nov 2009 13:14:05 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20091102184023.GB3805@pengutronix.de>
References: <1256925231-21917-1-git-send-email-w.sang@pengutronix.de>
	<1257175056-26093-1-git-send-email-w.sang@pengutronix.de>
	<fa686aa40911021002x6d895606s57bca0f9fdd4e81b@mail.gmail.com>
	<20091102184023.GB3805@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 2 Nov 2009 14:13:43 -0700
Message-ID: <fa686aa40911021313w6e28a45anc2833fc8aae25a6d@mail.gmail.com>
Subject: Re: [PATCH] mpc512x/clocks: initialize CAN clocks
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Chen Hongjun <hong-jun.chen@freescale.com>,
	John Rigby <jrigby@freescale.com>, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 2, 2009 at 11:40 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
>> It seems like the only shared bit seems to be access to the mccr registers.
>
> ...we can't access registers from two drivers?? Ah, wait, you are probably
> aiming at moving the mscan_init-function to the can-driver and to expose the
> mscan_calc_rate function from here? That sounds good in deed, will update!

Yup, that is exactly my thinking.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
