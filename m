Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 77268DDF9A
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 03:08:53 +1000 (EST)
Message-Id: <95BA4C47-8B99-4E94-9855-4333BB4A751C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <49EF4E27.9020203@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH v3] powerpc/85xx: Add P2020DS board support
Date: Wed, 22 Apr 2009 12:06:43 -0500
References: <1240371105-18400-1-git-send-email-galak@kernel.crashing.org>
	<20090422164400.GA9592@ld0162-tx32.am.freescale.net>
	<6EC8B59D-62C8-4D9B-B548-4833A06F13AB@kernel.crashing.org>
	<49EF4E27.9020203@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 22, 2009, at 12:04 PM, Scott Wood wrote:

> Kumar Gala wrote:
>>> If this has an elbc more recent than 1.0 (looks like it), we should
>>> indicate that here.
>> that might be the case, but I leave it to u-boot to do that.
>
> Why?  There's no p2020 with an older eLBC, and there's no block  
> version register.

But there might be a p2020 w/a newer eLBC version in the future.

- k
