Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 93E47B7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 Nov 2009 00:12:06 +1100 (EST)
Date: Tue, 10 Nov 2009 13:03:43 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] ASoC/mpc5200: remove duplicate identical IRQ handler
Message-ID: <20091110130343.GD16200@rakim.wolfsonmicro.main>
References: <20091109163936.29231.482.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091109163936.29231.482.stgit@angua>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
	lrg@slimlogic.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 09, 2009 at 09:40:09AM -0700, Grant Likely wrote:
> The TX and RX irq handlers are identical.  Merge them

Applied, thanks.
