Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 46563DDE05
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 17:45:33 +1100 (EST)
Date: Thu, 20 Mar 2008 07:45:42 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: crash in init_ipic_sysfs on efika
Message-ID: <20080320064542.GA11434@aepfle.de>
References: <20080317195305.GA13298@aepfle.de>
	<18400.41990.995316.729968@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <18400.41990.995316.729968@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 19, Paul Mackerras wrote:

> Olaf Hering writes:
> 
> > I cant reproduce this bug on my board, but:
> > 
> > The global primary_ipic in arch/powerpc/sysdev/ipic.c can remain NULL if
> > ipic_init() fails. init_ipic_sysfs() will crash in that case.
> > 
> > Something like this may fix it:
> 
> Is this needed for 2.6.25?  Is the system at all usable if ipic_init
> fails?

CONFIG_PPC_MPC51* needs to be disabled for pmac/chrp/bplan .configs.

A full featured ppc32_defconfig will probably catch such errors.
