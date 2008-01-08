Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 582AEDDF06
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 18:36:45 +1100 (EST)
Message-Id: <FB3D7D27-D06F-4AD2-B4A1-00FBA26251AF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Li Yang <leoli@freescale.com>
In-Reply-To: <1199707400-23588-1-git-send-email-leoli@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 1/3] add default device trees for MPC837x MDS board
Date: Tue, 8 Jan 2008 01:36:34 -0600
References: <1199707400-23588-1-git-send-email-leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 7, 2008, at 6:03 AM, Li Yang wrote:

> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> address comments and use new dts spec.
>
> arch/powerpc/boot/dts/mpc8377_mds.dts |  277 ++++++++++++++++++++++++ 
> +++++++
> arch/powerpc/boot/dts/mpc8378_mds.dts |  263 ++++++++++++++++++++++++ 
> +++++
> arch/powerpc/boot/dts/mpc8379_mds.dts |  291 ++++++++++++++++++++++++ 
> +++++++++
> 3 files changed, 831 insertions(+), 0 deletions(-)

Could I convince you to convert these to dts-v1 format?

- k
