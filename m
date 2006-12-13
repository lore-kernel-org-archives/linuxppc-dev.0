Return-Path: <tnt@246tNt.com>
Received: from outmx006.isp.belgacom.be (outmx006.isp.belgacom.be
	[195.238.4.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4E08967C11
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 06:06:29 +1100 (EST)
Received: from outmx006.isp.belgacom.be (localhost [127.0.0.1])
	by outmx006.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id kBDJ6DM0009979
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 20:06:16 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <45804EE0.7090504@246tNt.com>
Date: Wed, 13 Dec 2006 20:05:04 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [POWERPC] Change mpc52xx Kconfig entries to match other freescale
	parts
References: <11660366142752-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <11660366142752-git-send-email-grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> All other Freescale parts use Kconfig defines of the form: PPC_8?xx
> The MPC52xx is currently in the form: PPC_MPC52xx.  This commit changes
> it to PPC_52xx for consistency sake.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>
>   
Acked-by: Sylvain Munaut <tnt@246tNt.com>
