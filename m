Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (www.linutronix.de [62.245.132.108])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C2A252C038D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 17:54:50 +1000 (EST)
Message-ID: <51CD4125.5060305@linutronix.de>
Date: Fri, 28 Jun 2013 09:54:13 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH] of: Specify initrd location using 64-bit
References: <1371775956-16453-1-git-send-email-santosh.shilimkar@ti.com>
 <51C4171C.9050908@linutronix.de> <51C48B5A.2040404@ti.com>
 <51CCA67C.2010803@gmail.com>
In-Reply-To: <51CCA67C.2010803@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-mips@linux-mips.org,
 Aurelien Jacquiot <a-jacquiot@ti.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Jonas Bonn <jonas@southpole.se>, Russell King <linux@arm.linux.org.uk>,
 linux-c6x-dev@linux-c6x.org, x86@kernel.org, arm@kernel.org,
 Mark Salter <msalter@redhat.com>, Grant Likely <grant.likely@linaro.org>,
 linux-xtensa@linux-xtensa.org, James Hogan <james.hogan@imgtec.com>,
 devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>,
 linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>,
 Michal Simek <monstr@monstr.eu>, Vineet Gupta <vgupta@synopsys.com>,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 Santosh Shilimkar <santosh.shilimkar@ti.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/27/2013 10:54 PM, Rob Herring wrote:

>> Rob,
>> Are you ok with phys_addr_t since your concern was about rest
>> of the memory specific bits of the device-tree code use u64 ?
> 
> No. I still think it should be u64 for same reasons I said originally.

The physical address space is represented by phys_addr_t and not u64
within the kernel. If you go for u64 you may waste 32bit and you need
to check if the running kernel can deal with this.
Why was u64 such a good thing?

> Rob

Sebastian
