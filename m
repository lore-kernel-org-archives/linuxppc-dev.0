Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 79C50DE35C
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 21:51:51 +1000 (EST)
In-Reply-To: <1208597267-30960-3-git-send-email-Jason.jin@freescale.com>
References: <1208597267-30960-1-git-send-email-Jason.jin@freescale.com>
	<1208597267-30960-2-git-send-email-Jason.jin@freescale.com>
	<1208597267-30960-3-git-send-email-Jason.jin@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <954025a54c1975c6ddb86584b865b92e@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 3/3] Enable MSI support for 85xxds board.
Date: Fri, 18 Apr 2008 13:51:37 +0200
To: Jason Jin <Jason.jin@freescale.com>
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +		msi@41600 {
> +			compatible = "fsl,MPIC-msi";

You need a more exact name here.

Also, where's the binding documentation?


Segher
