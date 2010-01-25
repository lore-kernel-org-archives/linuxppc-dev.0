Return-Path: <ptyser@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 09BB71007D2
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jan 2010 04:20:46 +1100 (EST)
Subject: Re: [PATCH 1/4] edac: Remove unused mpc85xx debug code
From: Peter Tyser <ptyser@xes-inc.com>
To: bluesmoke-devel@lists.sourceforge.net
In-Reply-To: <1258677749-15968-1-git-send-email-ptyser@xes-inc.com>
References: <1258677749-15968-1-git-send-email-ptyser@xes-inc.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 25 Jan 2010 11:20:13 -0600
Message-ID: <1264440013.22019.19.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, djiang@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-11-19 at 18:42 -0600, Peter Tyser wrote:
> Some unused, unsupported debug code existed in the mpc85xx EDAC driver
> that resulted in a build failure when CONFIG_EDAC_DEBUG was defined:
> 
>   drivers/edac/mpc85xx_edac.c: In function 'mpc85xx_mc_err_probe':
>   drivers/edac/mpc85xx_edac.c:1031: error: implicit declaration of function 'edac_mc_register_mcidev_debug'
>   drivers/edac/mpc85xx_edac.c:1031: error: 'debug_attr' undeclared (first use in this function)
>   drivers/edac/mpc85xx_edac.c:1031: error: (Each undeclared identifier is reported only once
>   drivers/edac/mpc85xx_edac.c:1031: error: for each function it appears in.)
> 
> Signed-off-by: Peter Tyser <ptyser@xes-inc.com>

<snip>

Any chance some of these will be picked up for 2.6.33?

I added Kumar on CC as I'm not sure if these should go through the EDAC
or PPC tree.

1/4 fixes a build error when CONFIG_EDAC_DEBUG is defined and is pretty
trivial.

2/4 fixes a regression which results in ECC detection not working.

3/4 and 4/4 are "improvements", but don't necessarily need to go into
2.6.33.

Best,
Peter
