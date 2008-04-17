Return-Path: <neko@genesi-usa.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.184])
	by ozlabs.org (Postfix) with ESMTP id 19650DE8CC
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 00:23:16 +1000 (EST)
Received: by fk-out-0910.google.com with SMTP id z22so136088fkz.9
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 07:23:13 -0700 (PDT)
Message-ID: <48075D4B.7030501@genesi-usa.com>
Date: Thu, 17 Apr 2008 15:23:07 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: RFC: MPC5200 PSC AC97 driver
References: <47FDEF9B.5000506@semihalf.com>	<200804151003.17865.jbe@pengutronix.de>	<200804161324.15887.jbe@pengutronix.de>
	<200804171619.56615.jbe@pengutronix.de>
In-Reply-To: <200804171619.56615.jbe@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Juergen Beisert wrote:
> Hi,

Hooray! :)

Does it work, though, with your board?

> -	u16		ccr;		/* PSC + 0x20 */
> -	u8		reserved7[14];
> +	u32		ccr;		/* PSC + 0x20 */
> +	u32		ac97_slots;	/* PSC + 0x24 */

I think it should be left noted here that the CCR size changed from
16 bits to 32 bits from 5200 to 5200B in order to reduce confusion.
You may have read the manual but that does not mean that an extra
small comment would not be appreciated by a lot of people (after
all who would want to write code for a legacy 5200 device, write
to psc->ccr and wonder why it explodes?)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
