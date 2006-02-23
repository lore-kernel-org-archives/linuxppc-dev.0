Return-Path: <SRS0+eb7ae25f47855baec100+914+infradead.org+dwmw2@canuck.srs.infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [205.233.218.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 72A5D67A06
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2006 04:22:55 +1100 (EST)
Subject: Re: yaboot 1.3.14 release candidate 1
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Nasrat <pnasrat@redhat.com>
In-Reply-To: <1140021795.2824.12.camel@enki.eridu>
References: <1139538538.3638.14.camel@enki.eridu>
	<1139581305.5851.7.camel@grayson> <1140021795.2824.12.camel@enki.eridu>
Content-Type: text/plain
Date: Thu, 23 Feb 2006 17:22:38 +0000
Message-Id: <1140715358.22730.23.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-02-15 at 11:43 -0500, Paul Nasrat wrote:
> No, thanks for passing this on to me it looks sane, I'll test a little
> then probably commit.  Currently I've been doing this on macs with an
> ofboot script checking 64-bit, but this is probably better.

... and will work on CHRP for 32 vs. 64, which we can't do in
bootinfo.txt because of problems with the IBM firmware.

-- 
dwmw2
