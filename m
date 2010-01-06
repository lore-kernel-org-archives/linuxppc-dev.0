Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 000E6B6F05
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jan 2010 05:06:20 +1100 (EST)
Date: Wed, 6 Jan 2010 12:04:22 -0600
From: Scott Wood <scottwood@freescale.com>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: [PATCH 7/8] fsldma: rename fsl_chan to fchan
Message-ID: <20100106180422.GB27146@loki.buserror.net>
References: <1262326246-936-1-git-send-email-iws@ovro.caltech.edu>
	<1262326246-936-8-git-send-email-iws@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1262326246-936-8-git-send-email-iws@ovro.caltech.edu>
Cc: herbert@gondor.apana.org.au, B04825@freescale.com, linuxppc-dev@ozlabs.org,
	Vishnu@freescale.com, Dipen.Dudhat@freescale.com,
	dan.j.williams@intel.com, Maneesh.Gupta@freescale.com, R58472@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 31, 2009 at 10:10:45PM -0800, Ira W. Snyder wrote:
> The name fsl_chan seems too long, so it has been shortened to fchan.

Could be just "chan", no need for namespacing here.

-Scott
