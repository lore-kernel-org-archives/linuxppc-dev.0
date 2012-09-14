Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E9B592C007B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Sep 2012 00:21:23 +1000 (EST)
In-Reply-To: <20120914140234.GH2630@pengutronix.de>
References: <1346323204-19210-1-git-send-email-Joakim.Tjernlund@transmode.se>
 <20120914140234.GH2630@pengutronix.de>
Subject: Re: [PATCH] i2c-mpc: Wait for STOP to hit the bus
To: Wolfram Sang <w.sang@pengutronix.de>
Message-ID: <OF06A39459.C875C05A-ONC1257A79.004E987A-C1257A79.004EDA28@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Fri, 14 Sep 2012 16:21:16 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Wolfram Sang <w.sang@pengutronix.de> wrote on 2012/09/14 16:02:34:
>
> On Thu, Aug 30, 2012 at 12:40:04PM +0200, Joakim Tjernlund wrote:
> > mpc_i2c_stop() only initiates STOP but does not wait for it to
> > hit the I2C bus. This is a problem when using I2C devices which
> > uses fairly long clock stretching just before STOP if you also
> > have an i2c-mux which may switch to another bus before STOP has
> > been processed.
> >
> > Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
>
> Patch didn't apply, because it was a p0-patch. Checkpatch would have
> warned you.

Bugger, it is my git config setting:
[diff]
	noprefix = true

I always forget to remove that one before generating patches, I will have to remove it.

>
> Fixed that and applied to -next, thanks!

Thanks
