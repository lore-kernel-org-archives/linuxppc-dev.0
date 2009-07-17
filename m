Return-Path: <wd@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A14E6B7B62
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jul 2009 22:35:24 +1000 (EST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 372F3DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Jul 2009 22:35:23 +1000 (EST)
To: Wolfram Sang <w.sang@pengutronix.de>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 2/2 v2] MPC52xx FEC: be more conservative when setting
	MII_SPEED register
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <20090717094725.GC3150@pengutronix.de>
References: <1247671133-12148-1-git-send-email-wd@denx.de>
	<1247780546-4426-2-git-send-email-wd@denx.de>
	<20090717094725.GC3150@pengutronix.de>
Date: Fri, 17 Jul 2009 14:35:19 +0200
Message-Id: <20090717123519.C7E1D832E416@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Wolfram Sang,

In message <20090717094725.GC3150@pengutronix.de> you wrote:
> 
> In the probe-function when mdio_speed is set, there is still the old formula
> used. Wouldn't that be better in sync?

Good point. Next version of patch following soon.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Prof:        So the American government went to IBM to come up with a
             data encryption standard and they came up with ...
Student:     EBCDIC!
