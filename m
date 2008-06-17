Return-Path: <jrigby@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 93473DE501
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 05:43:56 +1000 (EST)
Message-ID: <485813EC.6030602@freescale.com>
Date: Tue, 17 Jun 2008 13:43:40 -0600
From: John Rigby <jrigby@freescale.com>
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] [Rev2] MPC5121 FEC support
References: <1213729717-26688-1-git-send-email-jrigby@freescale.com>
	<20080617192237.GA12961@uranus.ravnborg.org>
In-Reply-To: <20080617192237.GA12961@uranus.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Thanks Sam,  Scott already addressed most of your issues.  The 
background that you are likely missing and I will add to the patch 
header is that the 5121 has an FEC core with all the same registers as 
8xx except the order of the registers is scrambled.  Fortunately the old 
FEC only exists on CPM1 machines so we can use CONFIG_CPM1 to 
differentiate between the two.


>
> I we have a conversion from fec_t to struct fec
> then this is a separate patch in the normal case.
>   
I'll split the patch into a clean-up patch followed by a 5121 patch.
