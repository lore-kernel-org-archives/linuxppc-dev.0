Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8AB45DDEFD
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2009 22:46:04 +1100 (EST)
Message-Id: <B7E242B3-7179-4BDD-A3D5-330400F2D6B3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <1236817324-24612-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH v3] powerpc: clean up ssi.txt, add definition for fsl,
	ssi-asynchronous
Date: Fri, 27 Mar 2009 06:45:51 -0500
References: <1236817324-24612-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 11, 2009, at 7:22 PM, Timur Tabi wrote:

> Add the definition of the fsl,ssi-asynchronous property to ssi.txt  
> (documentation
> of the device tree bindings for the Freescale SSI device).
>
> Also tidy up the layout of ssi.txt.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> v3: rebased
>
> v2: fixed typo, improved wording.
>
> Documentation/powerpc/dts-bindings/fsl/ssi.txt |   68 +++++++++++++ 
> +----------
> 1 files changed, 39 insertions(+), 29 deletions(-)


applied to next

- k
