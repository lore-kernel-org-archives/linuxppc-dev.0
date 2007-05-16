Return-Path: <sr@denx.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.188])
	by ozlabs.org (Postfix) with ESMTP id 9A981DDF2E
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 04:44:00 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: [PATCH] ibm_emac: Correctly detect old link speed
Date: Wed, 16 May 2007 20:44:47 +0200
References: <200705161300.08521.sr@denx.de>
	<20070516173002.GA22331@gate.ebshome.net>
In-Reply-To: <20070516173002.GA22331@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705162044.47776.sr@denx.de>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 16 May 2007, Eugene Surovegin wrote:
> On Wed, May 16, 2007 at 01:00:08PM +0200, Stefan Roese wrote:
> > This patch fixes a bug where the link speed change was not
> > detected correctly. This occured on a 440SPe (EMAC4) system
> > where the old link speed was 100Mbps and the new link speed
> > is 1000Mbps.
>
> Good catch, Stefan. Unfortunately, I have to NACK your patch - you
> broke non EMAC4 builds.

Yes, you're right of course.

> Correct fix is just to remove EMAC_MR1_MF_1000GPCS from the first
> if condition.

Yep.

> I'll send correct fix shortly along with other queued patches.

Thanks.

Best regards,
Stefan
