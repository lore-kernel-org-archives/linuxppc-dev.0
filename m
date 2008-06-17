Return-Path: <sam@ravnborg.org>
Received: from pasmtpA.tele.dk (pasmtpa.tele.dk [80.160.77.114])
	by ozlabs.org (Postfix) with ESMTP id 82812DE7E4
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 05:56:55 +1000 (EST)
Date: Tue, 17 Jun 2008 21:57:39 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] [Rev2] MPC5121 FEC support
Message-ID: <20080617195739.GB13147@uranus.ravnborg.org>
References: <1213729717-26688-1-git-send-email-jrigby@freescale.com>
	<48581188.90102@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48581188.90102@freescale.com>
Cc: linuxppc-dev@ozlabs.org, jeff@garzik.org, John Rigby <jrigby@freescale.com>,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 17, 2008 at 02:33:28PM -0500, Scott Wood wrote:
> John Rigby wrote:
> > config FS_ENET
> >        tristate "Freescale Ethernet Driver"
> >-       depends on CPM1 || CPM2
> >+       depends on CPM1 || CPM2 || FS_ENET_MPC5121_FEC
> >        select MII
> >        select PHYLIB
> > 
> >+config FS_ENET_MPC5121_FEC
> >+	bool "Freescale MPC512x FEC driver"
> >+	depends on PPC_MPC512x
> >+	select FS_ENET
> >+	select PPC_CPM_NEW_BINDING
> >+	default y
> 
> No default y.
I by the way do not see the need for the prompt of FS_ENET.
Do you ever want to change it if one of the dependencies
are selected?

	Sam
