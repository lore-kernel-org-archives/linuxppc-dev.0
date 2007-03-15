Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id AE384DDDFB
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 01:56:50 +1100 (EST)
Message-ID: <45F95EAD.1050202@freescale.com>
Date: Thu, 15 Mar 2007 09:56:45 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: fix invalid pointer usage in ucc_slow_init()
References: <1173970133624-git-send-email-timur@freescale.com>
	<CB8634B4-7150-4D0D-942C-76BC55C43749@kernel.crashing.org>
In-Reply-To: <CB8634B4-7150-4D0D-942C-76BC55C43749@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> It's my understanding that there aren't any in kernel users of ucc_slow 
> at the moment, is that true?

Yes.  I'm working on the first - a UART driver.
