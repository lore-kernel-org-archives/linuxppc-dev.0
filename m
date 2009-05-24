Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3ABFEDE087
	for <linuxppc-dev@ozlabs.org>; Sun, 24 May 2009 22:12:30 +1000 (EST)
Date: Sun, 24 May 2009 13:12:17 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jon Smirl <jonsmirl@gmail.com>
Message-ID: <20090524121216.GH4933@sirena.org.uk>
References: <20090523231148.17919.46103.stgit@terra>
	<20090523231311.17919.38581.stgit@terra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090523231311.17919.38581.stgit@terra>
Subject: Re: [alsa-devel] [PATCH V2 8/9] Fabric bindings for STAC9766 on
	the Efika
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, May 23, 2009 at 07:13:11PM -0400, Jon Smirl wrote:
> Fabric bindings for STAC9766 AC97 codec on the Efika.
> 
> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>

This is OK, but obviously depends on previous patches so I'll not apply
it just yet.  You might want to run it (and many of your other patches)
through checkpatch, though.  One nit:

> +static __exit void efika_fabric_exit(void)
> +{
> +}

This should either do something or be removed.
