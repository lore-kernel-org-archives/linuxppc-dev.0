Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6F61AB709C
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Jun 2009 09:35:47 +1000 (EST)
Received: from mail-gx0-f216.google.com (mail-gx0-f216.google.com
	[209.85.217.216]) by ozlabs.org (Postfix) with ESMTP id C860DDDD1B
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jun 2009 09:35:46 +1000 (EST)
Received: by gxk12 with SMTP id 12so934486gxk.9
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jun 2009 16:35:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090626222900.GA14594@oksana.dev.rtsoft.ru>
References: <20090626222900.GA14594@oksana.dev.rtsoft.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 26 Jun 2009 17:35:25 -0600
Message-ID: <fa686aa40906261635i2b7fb95bsb6b7357c1bc288f0@mail.gmail.com>
Subject: Re: [PATCH 0/4 for 2.6.31] NET: Revive fixed link support
To: avorontsov@ru.mvista.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: netdev@vger.kernel.org, Li Yang <leoli@freescale.com>,
	Andy Fleming <afleming@freescale.com>,
	David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 26, 2009 at 4:29 PM, Anton
Vorontsov<avorontsov@ru.mvista.com> wrote:
> Hi all,
>
> The fixed link support is broken since The Big OF MDIO Rework,
> the rework simply removed most of the code that was needed for
> fixed links.
>
> Too bad I didn't notice this earlier, I saw a bunch of patches
> on the ml, but unfortunately I didn't look very close presuming
> that Grant knew what he was doing. :-) And obviously I didn't
> test linux-next on anything that requires a fixed link.

Apparently I didn't.  sorry.

> Anyway, here are four patches. The first one adds the fixed link
> support to a framework, otherwise we'd duplicate the code across
> the drivers (as we did previously), and I tried to keep drivers'
> changes minimal.

As I described in my previous email, I don't think this is a good
approach and I don't think it should be merged.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
