Return-Path: <sfalco@harris.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 741BDB70A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Jun 2009 00:37:05 +1000 (EST)
Received: from mlbe2k1.cs.myharris.net (mlbe2k1.cs.myharris.net
	[137.237.90.88]) by ozlabs.org (Postfix) with ESMTP id CB43FDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2009 00:37:04 +1000 (EST)
Message-ID: <4A423A0A.2010004@harris.com>
Date: Wed, 24 Jun 2009 10:36:58 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: [Question] m25p80 driver versus spi clock rate
References: <4A3FEE98.60700@harris.com>
	<200906231538.40125.david-b@pacbell.net>
	<4A423750.8080605@harris.com> <200906241633.35571.sr@denx.de>
In-Reply-To: <200906241633.35571.sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
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

Stefan Roese wrote:
> On Wednesday 24 June 2009 16:25:20 Steven A. Falco wrote:
>>> Speaking of spi_ppc4xx issues ... I still have an oldish
>>> copy in my review queue, it needs something like the
>>> appended patch.  (Plus something to accept bpw == 0.)
>>> Is there a newer version?
>> That is a question for Stefan.  Perhaps when I post my patch
>> to the PPC list, we can move this further along...
> 
> I have to admit that I didn't find the time to rework the driver after David's 
> latest review. Frankly, this could take some time since I'm currently busy 
> with other tasks. So it would be great if someone else (Steven?) might pick up 
> here and resubmit this driver so that we can get it finally included.
> 
> Thanks.
> 
> Best regards,
> Stefan

Ok - I'll take that on.

Please, both David and Stefan send me the latest versions
and/or patches you have, and I'll integrate them and post
to the PPC list.

	Steve


-- 
A: Because it makes the logic of the discussion difficult to follow.
Q: Why shouldn't I top post?
A: No.
Q: Should I top post?
