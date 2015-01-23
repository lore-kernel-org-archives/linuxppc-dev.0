Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AA18E1A0C7F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 14:04:52 +1100 (AEDT)
Message-ID: <1421982291.24984.8.camel@ellerman.id.au>
Subject: Re: [PATCH v2 1/1] powerpc: refresh mpc85xx_defconfig using "make
 savedefconfig"
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alessio Igor Bogani <alessio.bogani@elettra.eu>
Date: Fri, 23 Jan 2015 14:04:51 +1100
In-Reply-To: <1421655056-7860-1-git-send-email-alessio.bogani@elettra.eu>
References: <1421655056-7860-1-git-send-email-alessio.bogani@elettra.eu>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-01-19 at 09:10 +0100, Alessio Igor Bogani wrote:
> Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
> ---
> 
> v1 -> v2
> 	Rebased on v3.19-rc5

In the end I did do a bulk update of all configs, which I think means this is
obsolete.

  https://git.kernel.org/cgit/linux/kernel/git/mpe/linux.git/commit/?h=next&id=a85cade6762bf566698e625ec1a4461245e40768

cheers
