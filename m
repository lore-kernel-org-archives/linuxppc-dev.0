Return-Path: <sam@ravnborg.org>
Received: from pasmtpB.tele.dk (pasmtpb.tele.dk [80.160.77.98])
	by ozlabs.org (Postfix) with ESMTP id E5B8BDEB40
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 05:57:15 +1000 (EST)
Date: Tue, 17 Jun 2008 21:57:59 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: John Rigby <jrigby@freescale.com>
Subject: Re: [PATCH] [Rev2] MPC5121 FEC support
Message-ID: <20080617195759.GC13147@uranus.ravnborg.org>
References: <1213729717-26688-1-git-send-email-jrigby@freescale.com>
	<20080617192237.GA12961@uranus.ravnborg.org>
	<485813EC.6030602@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <485813EC.6030602@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	jeff@garzik.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 17, 2008 at 01:43:40PM -0600, John Rigby wrote:
> Thanks Sam,  Scott already addressed most of your issues.  The 
> background that you are likely missing and I will add to the patch 
> header is that the 5121 has an FEC core with all the same registers as 
> 8xx except the order of the registers is scrambled.  Fortunately the old 
> FEC only exists on CPM1 machines so we can use CONFIG_CPM1 to 
> differentiate between the two.
> 
> 
> >
> >I we have a conversion from fec_t to struct fec
> >then this is a separate patch in the normal case.
> >  
> I'll split the patch into a clean-up patch followed by a 5121 patch.

Thanks John.

	Sam
