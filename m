Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A5C7E68623
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Oct 2005 07:19:15 +1000 (EST)
Date: Sat, 22 Oct 2005 23:19:06 +0200
From: Olaf Hering <olh@suse.de>
To: Brad Boyer <flar@allandria.com>
Message-ID: <20051022211906.GA5820@suse.de>
References: <20051022194626.GA3496@suse.de> <20051022210122.GA9638@pants.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20051022210122.GA9638@pants.nu>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] dmasound_pmac depends on pmac specific config options
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Sat, Oct 22, Brad Boyer wrote:

> I disagree. I think a much better solution would be to change the
> code to be conditionalized internally on PMU support, rather than
> having #ifdef CONFIG_PM since the functions being called inside
> that protection are actually out of the PMU code, not the generic
> power management system. By doing this, you could for example
> have a kernel compiled for a 1st gen PCI PowerMac without any
> extra drivers. In this case, you have CUDA and AWACS, but there
> is no PMU support and no need for sleep notifiers.

May patch would allow that, you need either CUDA or PMU support.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
