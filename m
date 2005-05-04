Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 469F5679F2
	for <linuxppc-dev@ozlabs.org>; Wed,  4 May 2005 21:28:40 +1000 (EST)
In-Reply-To: <17016.29775.224816.691409@cargo.ozlabs.ibm.com>
References: <17016.29775.224816.691409@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <466e699745cf24e660e296530f6e34dc@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Wed, 4 May 2005 07:28:30 -0400
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, trini@kernel.crashing.org
Subject: Re: [PATCH] Set cpu explicitly in kernel compiles
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 4, 2005, at 3:05 AM, Paul Mackerras wrote:

> +cpu-opt-$(CONFIG_6xx)		+= -mcpu=750 -mtune=7450

What about cores that aren't CONFIG_6xx (8xx, 4xx, e500, etc.)?

How about we create a CONFIG_GCC_CPUOPT and
CONFIG_AS_OPT, and just get these out of the configuration file?


	-- Dan
