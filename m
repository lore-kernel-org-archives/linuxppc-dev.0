Return-Path: <sr@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DE1ECB7083
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Jun 2009 00:33:44 +1000 (EST)
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.180])
	by ozlabs.org (Postfix) with ESMTP id 146ADDDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2009 00:33:42 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: [Question] m25p80 driver versus spi clock rate
Date: Wed, 24 Jun 2009 16:33:35 +0200
References: <4A3FEE98.60700@harris.com>
	<200906231538.40125.david-b@pacbell.net>
	<4A423750.8080605@harris.com>
In-Reply-To: <4A423750.8080605@harris.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200906241633.35571.sr@denx.de>
Cc: David Brownell <david-b@pacbell.net>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	linux-mtd@lists.infradead.org, Mike Frysinger <vapier.adi@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 24 June 2009 16:25:20 Steven A. Falco wrote:
> > Speaking of spi_ppc4xx issues ... I still have an oldish
> > copy in my review queue, it needs something like the
> > appended patch.  (Plus something to accept bpw == 0.)
> > Is there a newer version?
>
> That is a question for Stefan.  Perhaps when I post my patch
> to the PPC list, we can move this further along...

I have to admit that I didn't find the time to rework the driver after David's 
latest review. Frankly, this could take some time since I'm currently busy 
with other tasks. So it would be great if someone else (Steven?) might pick up 
here and resubmit this driver so that we can get it finally included.

Thanks.

Best regards,
Stefan
