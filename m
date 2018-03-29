Return-Path: <okaya@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BmVy0GPfzDqmx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2018 00:56:07 +1100 (AEDT)
Subject: Re: RFC on writel and writel_relaxed
To: David Miller <davem@davemloft.net>, benh@kernel.crashing.org
Cc: torvalds@linux-foundation.org, alexander.duyck@gmail.com,
 will.deacon@arm.com, arnd@arndb.de, jgg@ziepe.ca, David.Laight@aculab.com,
 oohall@gmail.com, linuxppc-dev@lists.ozlabs.org, linux-rdma@vger.kernel.org,
 alexander.h.duyck@redhat.com, paulmck@linux.vnet.ibm.com,
 netdev@vger.kernel.org, linus971@gmail.com
References: <CA+55aFxULkhZGhg-tTBBxBBvXbL7QV7f6zvwW7U2wHFijqGEqw@mail.gmail.com>
 <b02cc752d90c5e5ae2cc8cc4f67429a7@codeaurora.org>
 <1522249996.21446.25.camel@kernel.crashing.org>
 <20180328.115509.481837809903086401.davem@davemloft.net>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <29fe17e0-9978-dc43-d02c-de8fabdc66c2@codeaurora.org>
Date: Thu, 29 Mar 2018 09:56:01 -0400
MIME-Version: 1.0
In-Reply-To: <20180328.115509.481837809903086401.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 3/28/2018 11:55 AM, David Miller wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Thu, 29 Mar 2018 02:13:16 +1100
> 
>> Let's fix all archs, it's way easier than fixing all drivers. Half of
>> the archs are unused or dead anyway.
> 
> Agreed.
> 

I pinged most of the maintainers yesterday.
Which arches do we care about these days?
I have not been paying attention any other architecture besides arm64.

arch		status			detail
------		-------------		------------------------------------
alpha		question sent
arc		question sent		ysato@users.sourceforge.jp will fix it.
arm		no issues
arm64		no issues
blackfin	question sent		about to be removed
c6x		question sent
cris		question sent
frv
h8300		question sent
hexagon		question sent
ia64		no issues		confirmed by Tony Luck
m32r
m68k		question sent
metag
microblaze	question sent
mips		question sent
mn10300		question sent
nios2		question sent
openrisc	no issues		shorne@gmail.com says should no issues
parisc		no issues		grantgrundler@gmail.com says most probably no problem but still looking
powerpc		no issues
riscv		question sent
s390		question sent
score		question sent
sh		question sent
sparc		question sent
tile		question sent
unicore32	question sent
x86		no issues
xtensa		question sent


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
