Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9406ADDEDF
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 17:31:52 +1100 (EST)
Message-Id: <5CAD9C8B-949A-48BB-AD7E-B2D1F4C99CCC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Li Yang <leoli@freescale.com>
In-Reply-To: <1199707400-23588-1-git-send-email-leoli@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 1/3] add default device trees for MPC837x MDS board
Date: Fri, 18 Jan 2008 00:31:43 -0600
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

applied.

- k
