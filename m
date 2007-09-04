Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 027D6DDDCA
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2007 00:22:44 +1000 (EST)
In-Reply-To: <12472670.post@talk.nabble.com>
References: <12472670.post@talk.nabble.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <706FA05F-6E3E-4A9C-9DB0-52840E178F06@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Regarding immap_86xx.h
Date: Tue, 4 Sep 2007 09:25:16 -0500
To: sivaji <rameshmrm@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 4, 2007, at 1:38 AM, sivaji wrote:

>
> Hi,
>          I am using 2.6.23-rc3 kernel. In this kernel immap_86xx.h  
> file was
> loacted in the path: include/asm-powerpc/immap_86xx.h.
>
>           This file contains only PCI and Global utility Regsiters
> Declarations. LocalBus Controller, Local Access Registers and Rapid IO
> Register Declarations are missing.   Where i can find these registers
> declaration and tell the reason why the CCSRBAR Registers are  
> missing in the
> file immap_86xx.h

Its most likely been removed since these structures have been  
distributed to the places they are used.

- k
