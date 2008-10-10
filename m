Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 76BEBDDF6D
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 06:55:21 +1100 (EST)
Message-Id: <77450BB7-D444-41BE-AB53-2ECC1A10F9AF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20081010185321.GA16769@yoda.jdub.homelinux.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] Remove old workaround for arch/ppc vs. arch/powerpc from
	Makefile
Date: Fri, 10 Oct 2008 14:53:24 -0500
References: <20081010185321.GA16769@yoda.jdub.homelinux.org>
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 10, 2008, at 1:53 PM, Josh Boyer wrote:

> There is an old workaround in the sysdev/Makefile for dealing
> with arch/ppc vs. arch/powerpc compiles.  This is no longer
> needed as arch/ppc is dead.
>
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> ---

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k
