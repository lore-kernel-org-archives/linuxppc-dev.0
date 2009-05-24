Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6093DDE08D
	for <linuxppc-dev@ozlabs.org>; Sun, 24 May 2009 22:13:23 +1000 (EST)
Date: Sun, 24 May 2009 13:13:12 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jon Smirl <jonsmirl@gmail.com>
Message-ID: <20090524121311.GI4933@sirena.org.uk>
References: <20090523231148.17919.46103.stgit@terra>
	<20090523231313.17919.93066.stgit@terra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090523231313.17919.93066.stgit@terra>
Subject: Re: [alsa-devel] [PATCH V2 9/9] Support for AC97 on Phytec pmc030
	base board.
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, May 23, 2009 at 07:13:13PM -0400, Jon Smirl wrote:
> Support for AC97 on Phytec pmc030 base board. A wm9712 AC97 codec is used.
> 
> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>

Same comments as for the previous driver - it's OK once the AC97 DAI
driver goes in.
