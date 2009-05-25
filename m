Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DF8CFDE036
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 19:48:17 +1000 (EST)
Date: Mon, 25 May 2009 10:48:08 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH V3 3/4] Support for AC97 on Phytec pmc030 base board.
Message-ID: <20090525094724.GC18290@sirena.org.uk>
References: <20090525013606.3073.86753.stgit@terra>
	<20090525013851.3073.79847.stgit@terra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090525013851.3073.79847.stgit@terra>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, May 24, 2009 at 09:38:51PM -0400, Jon Smirl wrote:

> +static __exit void pcm030_fabric_exit(void)
> +{
> +}

Remove or implement, please.
