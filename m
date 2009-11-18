Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.182])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E15B81007D3
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2009 20:58:03 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] [PPC4xx] Fix device tree dts file for katmai board.
Date: Wed, 18 Nov 2009 10:57:49 +0100
References: <1258503588-7844-1-git-send-email-pbathija@amcc.com>
In-Reply-To: <1258503588-7844-1-git-send-email-pbathija@amcc.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200911181057.49585.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, pbathija@amcc.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Pravin,

On Wednesday 18 November 2009 01:19:48 pbathija@amcc.com wrote:
> From: Pravin Bathija <pbathija@amcc.com>
> 
>    Set size cell value to 2 for 4GB memory support in katmai. Also set
>  PCI-E node inbound DMA ranges size to 4GB for correct boot up of katmai.

As Josh already mentioned, I already submitted a patch which partly covers 
this 4GB support:

http://patchwork.ozlabs.org/patch/36768/

I suggest that you rebase your patch (only with the DMA ranges stuff) and 
resend it.

Cheers,
Stefan
