Return-Path: <linville@tuxdriver.com>
Received: from ra.tuxdriver.com (ra.tuxdriver.com [24.172.12.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E96BA684B6
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Nov 2005 05:20:56 +1100 (EST)
Date: Mon, 7 Nov 2005 13:20:34 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Pantelis Antoniou <panto@intracom.gr>
Message-ID: <20051107182031.GC13797@tuxdriver.com>
References: <20051106025701.GA9698@tuxdriver.com>
	<436F07F5.1030206@intracom.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <436F07F5.1030206@intracom.gr>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-embedded@ozlabs.org
Subject: Re: [patch 2.6.14] fec_8xx: make CONFIG_FEC_8XX depend on CONFIG_8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Nov 07, 2005 at 09:53:25AM +0200, Pantelis Antoniou wrote:
> John W. Linville wrote:

> >@@ -1,6 +1,6 @@
> > config FEC_8XX
> > 	tristate "Motorola 8xx FEC driver"
> >-	depends on NET_ETHERNET
> >+	depends on NET_ETHERNET && 8xx
> > 	select MII
> > 
> > config FEC_8XX_GENERIC_PHY
> 
> Yes, this is the correct approach. Please disregard the other
> patches floating about.

Pretty sure you are right.  However, a broken version already got
committed.  It added FEC as a dependency.  That keeps it from breaking
everyone else, but it make the driver available for Coldfire rather
than for PPC 8xx...

I'll reform that patch and repost.

John
-- 
John W. Linville
linville@tuxdriver.com
