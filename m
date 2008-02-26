Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 459E9DDF13
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 05:57:22 +1100 (EST)
Date: Tue, 26 Feb 2008 12:57:49 -0600
From: Scott Wood <scottwood@freescale.com>
To: "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com>
Subject: Re: Define CONFIG_PPC_NEW_BINDING
Message-ID: <20080226185749.GA3974@loki.buserror.net>
References: <F795765B112E7344AF36AA911279641502D1AAF2@xmb-sjc-212.amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F795765B112E7344AF36AA911279641502D1AAF2@xmb-sjc-212.amer.cisco.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 26, 2008 at 10:31:21AM -0800, Bizhan Gholikhamseh (bgholikh) wrote:
> Hi All,
> In order to define CONFIG_PPC_NEW_BINDING, which kernel configuration
> parameters should be selected (i.e. .config file)?

The kconfig entry for your board should contain the line
"select PPC_CPM_NEW_BINDING".

-Scott
