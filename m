Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 67857DDF5F
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Mar 2007 02:10:52 +1100 (EST)
In-Reply-To: <7EA18FDD2DC2154AA3BD6D2F22A62A0E5F6216@zch01exm23.fsl.freescale.net>
References: <20070305032307.GB31417@localhost.localdomain>
	<7EA18FDD2DC2154AA3BD6D2F22A62A0E5F6216@zch01exm23.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9A1B5311-2BE0-4757-A2EB-B4E316289FD0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Real time clock support in arch/powerpc
Date: Mon, 5 Mar 2007 09:10:47 -0600
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 5, 2007, at 2:02 AM, Zang Roy-r61911 wrote:

>
> Is there any plan to add real time clock support in arch/powerpc?
> I can find the support in arch/ppc/syslib/todc_time.c

I thought our intent was to try and start using the drivers rtc  
subsystem going forward.

- k
