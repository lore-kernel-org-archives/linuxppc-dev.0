Return-Path: <holt@sgi.com>
Received: from relay.sgi.com (relay1.sgi.com [192.48.179.29])
	by ozlabs.org (Postfix) with ESMTP id A99DBB71E1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Aug 2011 20:11:15 +1000 (EST)
Date: Wed, 10 Aug 2011 05:11:13 -0500
From: Robin Holt <holt@sgi.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v10 0/5] [flexcan/powerpc] Add support for powerpc
	flexcan (freescale p1010)
Message-ID: <20110810101113.GN4926@sgi.com>
References: <1312945564-6626-1-git-send-email-holt@sgi.com>
	<4E425716.4010104@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E425716.4010104@pengutronix.de>
Cc: netdev@vger.kernel.org, U Bhaskar-B22300 <B22300@freescale.com>,
	socketcan-core@lists.berlios.de, Robin Holt <holt@sgi.com>,
	PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 10, 2011 at 12:01:58PM +0200, Marc Kleine-Budde wrote:
> On 08/10/2011 05:05 AM, Robin Holt wrote:
> > With all the patches applied, my p1010rdb works for communicating between
> > its two can ports and also can communicate with an external PSOC.  I have
> > done no testing beyond compile testing on an arm system as I have no
> > access to an arm based system.
> > 
> > For the first three patches in the series, I believe they are all ready
> > for forwarding to David S. Miller for the netdev tree.  I think patch
> > 4 is ready for submission to the PPC85xx maintainer.  Patch 5 changed
> > from the previous post by adding a second compatible string for the
> > fsl,p1010_flexcan.
> 
> One remark for the subjects. It seems no one is using "[$subsystem]"
> anymore, but rather "$subsystem:".

I will, one day, get these patches subject lines correct ;)

Did you happen to get a chance to test the patches on arm?

Thanks,
Robin
