Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2552DDDF25
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jul 2008 03:48:54 +1000 (EST)
In-Reply-To: <20080717184843.GE25070@in.ibm.com>
References: <20080717183339.GA25070@in.ibm.com>
	<20080717184843.GE25070@in.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5bcb241a0597d5d23724c653e9c9b4eb@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC v3 PATCH 4/4] Relocation support
Date: Fri, 18 Jul 2008 19:48:10 +0200
To: mohan@in.ibm.com
Cc: ppcdev <linuxppc-dev@ozlabs.org>, paulus@samba.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> This patch changes all LOAD_REG_ADDR macro calls to LOAD_REG_IMMEDIATE
> to make sure that we load the correct address.

Did you figure out _why_ LOAD_REG_ADDR doesn't work?  Using
LOAD_REG_IMMEDIATE is actually a step back, it makes the kernel
binary non-PIC.  And LOAD_REG_ADDR _should_ work just fine with
your scheme.


Segher
