Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [208.106.21.240])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 77AFADDEF5
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 03:36:45 +1000 (EST)
Date: Wed, 16 May 2007 10:30:02 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] ibm_emac: Correctly detect old link speed
Message-ID: <20070516173002.GA22331@gate.ebshome.net>
References: <200705161300.08521.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200705161300.08521.sr@denx.de>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 16, 2007 at 01:00:08PM +0200, Stefan Roese wrote:
> This patch fixes a bug where the link speed change was not
> detected correctly. This occured on a 440SPe (EMAC4) system
> where the old link speed was 100Mbps and the new link speed
> is 1000Mbps.

Good catch, Stefan. Unfortunately, I have to NACK your patch - you 
broke non EMAC4 builds.

Correct fix is just to remove EMAC_MR1_MF_1000GPCS from the first 
if condition.

I'll send correct fix shortly along with other queued patches.

-- 
Eugene
