Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E589D67BE4
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Aug 2006 23:56:43 +1000 (EST)
In-Reply-To: <20060812000655.6186.42738.stgit@localhost.localdomain>
References: <20060812000655.6186.42738.stgit@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B55998EF-85A8-4694-9818-DB7C7A385569@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 0/6] POWERPC: Add support for CPM2 peripherals and 8560
	eval board
Date: Sat, 12 Aug 2006 08:56:40 -0500
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 11, 2006, at 6:42 PM, Vitaly Bordug wrote:

> The following series implements the generic cpm2 infrastructure port,
> mpc8560 board-specific bits, and an attempt to overhaul and get rid
> of some stuff moved along from the 2.4 times.
>
> Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>

Can you post the .dts for 8560 you are using.  I'd like to look at it  
before reviewing the patchset.

thanks

- kumar
