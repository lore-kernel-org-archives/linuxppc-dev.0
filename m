Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D086DDDFE2
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Mar 2008 03:05:12 +1100 (EST)
Message-Id: <D2A89054-3C19-444B-9155-FF8880E3100A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Li Yang <leoli@freescale.com>
In-Reply-To: <1204800155-11613-1-git-send-email-leoli@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 2/2] Add local bus device nodes to MPC837xMDS device trees.
Date: Fri, 7 Mar 2008 08:46:51 -0600
References: <1204800155-11613-1-git-send-email-leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 6, 2008, at 4:42 AM, Li Yang wrote:

> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/boot/dts/mpc8377_mds.dts     |   66 ++++++++++++++++++++ 
> +++++++++
> arch/powerpc/boot/dts/mpc8378_mds.dts     |   66 ++++++++++++++++++++ 
> +++++++++
> arch/powerpc/boot/dts/mpc8379_mds.dts     |   66 ++++++++++++++++++++ 
> +++++++++
> arch/powerpc/platforms/83xx/mpc837x_mds.c |    8 +--
> 4 files changed, 201 insertions(+), 5 deletions(-)

applied.

- k
