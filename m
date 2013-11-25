Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A34D02C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Nov 2013 06:06:51 +1100 (EST)
Date: Mon, 25 Nov 2013 20:06:41 +0100
From: Gerhard Sittig <gsi@denx.de>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 08/17] spi: mpc512x: adjust to OF based clock lookup
Message-ID: <20131125190641.GL2760@book.gsilab.sittig.org>
References: <1384729577-7336-1-git-send-email-gsi@denx.de>
 <1384729577-7336-9-git-send-email-gsi@denx.de>
 <20131125173008.GQ14725@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131125173008.GQ14725@sirena.org.uk>
Cc: Mike Turquette <mturquette@linaro.org>, Detlev Zundel <dzu@denx.de>,
 linux-spi@vger.kernel.org, Scott Wood <scottwood@freescale.com>,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 25, 2013 at 17:30 +0000, Mark Brown wrote:
> 
> On Mon, Nov 18, 2013 at 12:06:08AM +0100, Gerhard Sittig wrote:
> > after device tree based clock lookup became available, the peripheral
> > driver need no longer construct clock names which include the PSC index,
> > remove the "psc%d_mclk" template and unconditionally use 'mclk'
> 
> Have there been other changes which make this happen?

Not yet in mainline.  The patch you respond to is 08/17 within
the series, and depends on earlier patches in the series (namely
the introduction of CCF support for the MPC512x platform, making
the 'mclk' lookup against the PSC's OF node work while keeping
the global 'pscN_mclk' in place during migration).

This information was listed in the cover letter, but was not
duplicated within the individual patches.  Patches were sent to
individual Cc: lists to not spam too many people, but the cover
letter was CC'ed to every recipient of any part of the series.

Please note that I will have to re-submit the series, since it no
longer cleanly applies against v3.13-rc1 (which was not available
when I sent v5).  This patch won't change in its content, but may
experience changes in its context (catchup with changes between
v3.12 and v3.13-rc1).

Thank you for considering the patch, and for your feedback on
past versions!


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
