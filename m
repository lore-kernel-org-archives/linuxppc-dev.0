Return-Path: <david-b@pacbell.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 93540B7093
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Jun 2009 01:19:44 +1000 (EST)
Received: from smtp106.sbc.mail.gq1.yahoo.com (smtp106.sbc.mail.gq1.yahoo.com
	[67.195.14.109]) by ozlabs.org (Postfix) with SMTP id E73C7DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2009 01:19:43 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: [Question] m25p80 driver versus spi clock rate
Date: Wed, 24 Jun 2009 08:13:00 -0700
References: <4A3FEE98.60700@harris.com>
	<200906231538.40125.david-b@pacbell.net>
	<4A423750.8080605@harris.com>
In-Reply-To: <4A423750.8080605@harris.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200906240813.01220.david-b@pacbell.net>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Stefan Roese <sr@denx.de>, linux-mtd@lists.infradead.org,
	Mike Frysinger <vapier.adi@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 24 June 2009, Steven A. Falco wrote:
> Your changes to bitbang_work look good.

You tested?


> I'm not clear on why you first set do_setup = -1 but later 
> use do_setup = 1.  Perhaps they should both be "1".  Other than that,
> 
> Acked-by: Steven A. Falco <sfalco@harris.com>

The "-1" is for the init path, "1" for per-transfer overrides;
this way it avoids some extra calls to set up the bits/speed.
