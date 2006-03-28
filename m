Return-Path: <pnasrat@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 6FF5467A40
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2006 03:55:21 +1100 (EST)
Subject: Re: [PATCH] powerpc: Add FSL CPM2 device tree node documentation
From: Paul Nasrat <pnasrat@redhat.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>
In-Reply-To: <20060328161431.18517.82573.stgit@vitb.ru.mvista.com>
References: <20060328161431.18517.82573.stgit@vitb.ru.mvista.com>
Content-Type: text/plain
Date: Tue, 28 Mar 2006 11:55:10 -0500
Message-Id: <1143564910.2660.4.camel@enki.eridu>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Jon Loeliger <jdl@jdl.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-03-28 at 20:14 +0400, Vitaly Bordug wrote:
> Updated the documentation to include the initial description of the CPM2
> device that are used on PQII and PQIII families. Only initial sub-devices
> described so far, but that should be sufficient to move the respective
> boards to powerpc, with a reasonable minimum supporteddevice set.
> 

> +	5) FCCs (Fast Communications Controllers)
> +
> +	  Required properties:
> +
> +	  - device_type : should be "network"
> +	  - model : "FCCx", x is typically a small number depending on the
> +	  devices amount
> +	  - compatible : should be "fs_enet"
> +	  - address : List of bytes representing the ethernet address of
> +		this controller

Umm should we not use local-mac-address and mac-address (and
address-bits) as in section 3.7.4 in 1275-1994?

Paul
