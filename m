Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F3C59B7DB1
	for <linuxppc-dev@ozlabs.org>; Tue, 18 May 2010 01:51:43 +1000 (EST)
Subject: Re: [PATCH] powerpc: remove tls_ssl_stream descriptor type capability
	in sec3.3 node
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100422192513.27ce5356.kim.phillips@freescale.com>
Date: Mon, 17 May 2010 10:51:35 -0500
Message-Id: <068273A2-8B82-4FE0-BEE8-9FAB152D09D8@kernel.crashing.org>
References: <20100422192513.27ce5356.kim.phillips@freescale.com>
To: Kim Phillips <Kim.Phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 22, 2010, at 7:25 PM, Kim Phillips wrote:

> Technically, whilst SEC v3.3 h/w honours the tls_ssl_stream descriptor
> type, it lacks the ARC4 algorithm execution unit required to be able
> to execute anything meaningful with it.  Change the node to agree with
> the documentation that declares that the sec3.3 really doesn't have such
> a descriptor type.
> 
> Reported-by: Haiying Wang <Haiying.Wang@freescale.com>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
> arch/powerpc/boot/dts/mpc8315erdb.dts |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

applied to next

- k
