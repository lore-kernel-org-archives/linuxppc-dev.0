Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3A759DDF80
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 21:39:21 +1000 (EST)
Message-Id: <10860625-F419-4C9D-842D-7C0B1913A26C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Haiying Wang <Haiying.Wang@freescale.com>
In-Reply-To: <1241028878175-git-send-email-Haiying.Wang@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 1/6] powerpc/85xx: clean up for mpc8568_mds name
Date: Thu, 30 Apr 2009 06:37:11 -0500
References: <1241028878175-git-send-email-Haiying.Wang@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 29, 2009, at 1:14 PM, Haiying Wang wrote:

> Keep an unique machine def for the MPC8568 MDS board to handle some
> subtle differences between the future MDS board. Also set the bcsrs in
> setup_arch() only for mpc8568_mds because other mds has different  
> bcsr settings.
>
> Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
> ---
> arch/powerpc/platforms/85xx/mpc85xx_mds.c |   29 ++++++++++++++ 
> +--------------
> 1 files changed, 15 insertions(+), 14 deletions(-)

applied to next

- k
