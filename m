Return-Path: <sr@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2203FB7091
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Jun 2009 00:50:31 +1000 (EST)
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.181])
	by ozlabs.org (Postfix) with ESMTP id 2B766DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2009 00:50:29 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: [Question] m25p80 driver versus spi clock rate
Date: Wed, 24 Jun 2009 16:50:25 +0200
References: <4A3FEE98.60700@harris.com> <200906241633.35571.sr@denx.de>
	<4A423A0A.2010004@harris.com>
In-Reply-To: <4A423A0A.2010004@harris.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200906241650.26057.sr@denx.de>
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

On Wednesday 24 June 2009 16:36:58 Steven A. Falco wrote:
> > I have to admit that I didn't find the time to rework the driver after
> > David's latest review. Frankly, this could take some time since I'm
> > currently busy with other tasks. So it would be great if someone else
> > (Steven?) might pick up here and resubmit this driver so that we can get
> > it finally included.
> >
> > Thanks.
> >
> > Best regards,
> > Stefan
>
> Ok - I'll take that on.

Great, thanks.

> Please, both David and Stefan send me the latest versions
> and/or patches you have, and I'll integrate them and post
> to the PPC list.

I just sent you my latest driver version (v6). Here a link to David's latest 
review:

http://article.gmane.org/gmane.linux.ports.ppc64.devel/55229

Best regards,
Stefan
