Return-Path: <glikely@secretlab.ca>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.226])
	by ozlabs.org (Postfix) with ESMTP id 58CFADDE48
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 May 2007 03:02:30 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id z8so612676qbc
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 May 2007 10:02:28 -0700 (PDT)
Message-ID: <fa686aa40705251002m4956c3edt251c8e33637c94@mail.gmail.com>
Date: Fri, 25 May 2007 11:02:28 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Sylvain Munaut" <tnt@246tnt.com>
Subject: Re: [RFC 1/3] Re: [PATCH] mpc52xx_psc_spi: fix it for CONFIG_PPC_MERGE
In-Reply-To: <4656F7D2.8050603@246tNt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070516073707.GD9667@nd47.coderock.org>
	<464ABE97.7090603@246tNt.com>
	<20070525084304.GA23149@nd47.coderock.org>
	<4656F7D2.8050603@246tNt.com>
Cc: Dragos Carp <dragos.carp@toptica.com>, linuxppc-embedded@ozlabs.org,
	Domen Puncer <domen@coderock.org>, domen.puncer@telargo.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 5/25/07, Sylvain Munaut <tnt@246tnt.com> wrote:
> NACK
>
> Not at all what I meant ...
>
> We should not modify port config in any automatic way, just let the boot
> loader set it up.
> If it known not to do it propertly, then in the platform file
> (lite5200b, efika, ...)
> adjust port config according to what's really on the board.

I second that NACK.  Drivers must *never* touch port config.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
