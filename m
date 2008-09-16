Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D0AF6DE16B
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Sep 2008 04:42:07 +1000 (EST)
Message-Id: <472F96A3-1955-4A1A-88D8-815A44463036@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18639.61790.750450.103022@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: Please pull from 'for-2.6.27'
Date: Tue, 16 Sep 2008 13:41:58 -0500
References: <Pine.LNX.4.64.0809121546530.6192@blarg.am.freescale.net>
	<18BF734B-F71B-4FDD-B3C9-62AA5EB54283@kernel.crashing.org>
	<18639.61790.750450.103022@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 16, 2008, at 12:48 PM, Paul Mackerras wrote:

> Kumar Gala writes:
>
>>> Jochen Friedrich (1):
>>>     powerpc/cpm1: Fix race condition in CPM1 GPIO library.
>
> This looks like a biggish change for after -rc6, and the commit
> message doesn't tell me what dire things will happen if the patch
> doesn't go in, or what systems see this breakage, or whether this is a
> regression since 2.6.26 (I assume it isn't).  It doesn't even tell me
> why not being thread-safe is a problem on a UP machine.
>
> So... why does this fix need to go in at this stage?

We can probably hold off on that one as no one is screaming, can you  
cherry pick Timur's .dts patch as its a clear bug?

- k
