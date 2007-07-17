Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2BD3CDDEF6
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 08:15:04 +1000 (EST)
Message-ID: <469D3F60.8000401@freescale.com>
Date: Tue, 17 Jul 2007 17:14:56 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH v2] Allow exec on 32-bit from readable, non-exec pages,
	with a warning.
References: <20070709214853.GA29912@ld0162-tx32.am.freescale.net>
	<1184705168.24473.32.camel@ld0161-tx32>
In-Reply-To: <1184705168.24473.32.camel@ld0161-tx32>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Loeliger wrote:
> But luckily, this gave me the opportunity to then realize that
> we should give a great big...
> 
> Amen-brother-by: Jon Loeliger <jdl@freescale.com>
> 
> to this patch from Scott.
> 
> So, an official plea to Paul to apply this to his tree.

Segher has a newer patch that supersedes this one.  I don't know if he's 
posted it to the list yet, though.

-Scott
