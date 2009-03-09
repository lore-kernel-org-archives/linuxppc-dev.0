Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E29B6DE0C9
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 02:52:07 +1100 (EST)
Message-Id: <B611A44E-1CB9-48AE-9CB8-979361EC203C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <1236368634-20317-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH v2] powerpc: clean up ssi.txt, add definition for fsl,
	ssi-asynchronous
Date: Mon, 9 Mar 2009 10:51:57 -0500
References: <1236368634-20317-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 6, 2009, at 1:43 PM, Timur Tabi wrote:

> Add the definition of the fsl,ssi-asynchronous property to ssi.txt  
> (documentation
> of the device tree bindings for the Freescale SSI device).
>
> Also tidy up the layout of ssi.txt.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> v2: fixed typo, improved wording.
>
> Documentation/powerpc/dts-bindings/fsl/ssi.txt |   68 +++++++++++++ 
> +----------
> 1 files changed, 40 insertions(+), 28 deletions(-)

does not apply cleanly if/after I apply:

powerpc: add fsl, fifo-depth property to Freescale SSI device nodes


- k
