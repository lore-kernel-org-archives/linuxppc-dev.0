Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C427DDE2C7
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 04:32:10 +1000 (EST)
Message-ID: <48DA8796.5020304@freescale.com>
Date: Wed, 24 Sep 2008 13:31:50 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] fsl-dma: allow Freescale Elo DMA driver to be compiled
	as a module
References: <1221837088-19539-1-git-send-email-timur@freescale.com>
	<47B7FAA6-434C-440A-B55D-03C9882809CE@kernel.crashing.org>
In-Reply-To: <47B7FAA6-434C-440A-B55D-03C9882809CE@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: zw@zh-kernel.org, Dan Williams <dan.j.williams@intel.com>,
	Li Yang <leoli@freescale.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> Dan, any update on this patch?

I'm going to post a new version.  This whole thing is more complicated than I
thought.

-- 
Timur Tabi
Linux kernel developer at Freescale
