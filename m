Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7D9D6B729E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 15:58:26 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CC7B5DDD0C
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 15:58:25 +1000 (EST)
Message-Id: <0BAEE927-CAB0-4454-9F2E-B8DDCF3AFEDA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090618232208.GA11063@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH] powerpc/85xx: Fix FSL RapidIO probing on MDS boards
Date: Fri, 19 Jun 2009 00:58:03 -0500
References: <20090618232208.GA11063@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 18, 2009, at 6:22 PM, Anton Vorontsov wrote:

> From: Randy Vinson <rvinson@mvista.com>
>
> FSL RapidIO won't probe without a proper compatible entry. This
> patch fixes the issue by adding fsl,rapidio-delta compatible to
> mpc85xx_ids.
>
> Signed-off-by: Randy Vinson <rvinson@mvista.com>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/platforms/85xx/mpc85xx_mds.c |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)

applied

- k
