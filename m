Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 04FC0DDE1C
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 02:01:15 +1100 (EST)
In-Reply-To: <45F95EAD.1050202@freescale.com>
References: <1173970133624-git-send-email-timur@freescale.com>
	<CB8634B4-7150-4D0D-942C-76BC55C43749@kernel.crashing.org>
	<45F95EAD.1050202@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5BD50D5B-BA0E-40FA-B678-109E9D75F910@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: fix invalid pointer usage in ucc_slow_init()
Date: Thu, 15 Mar 2007 10:00:18 -0500
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 15, 2007, at 9:56 AM, Timur Tabi wrote:

> Kumar Gala wrote:
>
>> It's my understanding that there aren't any in kernel users of  
>> ucc_slow at the moment, is that true?
>
> Yes.  I'm working on the first - a UART driver.

Ok, I'll pull it into my tree for 2.6.22 then.

- k
