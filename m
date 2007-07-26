Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C5302DDE36
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 01:29:05 +1000 (EST)
In-Reply-To: <46A8BA58.4010208@freescale.com>
References: <11853846332917-git-send-email-timur@freescale.com>
	<8CEA1441-8408-48A9-A023-F072FBC3EEE2@kernel.crashing.org>
	<46A8BA58.4010208@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2C3AAEE8-EA91-4DBF-AF3E-D71FF592792A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] POWERPC: Fix definition of global-utilites structure for
	86xx
Date: Thu, 26 Jul 2007 10:29:50 -0500
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 26, 2007, at 10:14 AM, Timur Tabi wrote:

> Kumar Gala wrote:
>
>> Why don't we remove this completely, nothing uses it?
>
> Should I respin the patch to include updates to mpc86xx_restart()  
> to use it?

I'm wondering if we should change to code to use a #define GUT_RSTCR  
offset value since it only needs one register.

- k
