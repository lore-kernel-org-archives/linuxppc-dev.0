Return-Path: <cov@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwgWC6KWYzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 01:20:23 +1000 (AEST)
From: Christopher Covington <cov@codeaurora.org>
To: Catalin Marinas <catalin.marinas@arm.com>, criu@openvz.org,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Will Deacon <Will.Deacon@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: VDSO unmap and remap support for additional architectures
Date: Thu, 28 Apr 2016 11:18:52 -0400
Message-Id: <1461856737-17071-1-git-send-email-cov@codeaurora.org>
In-Reply-To: <20151202121918.GA4523@arm.com>
References: <20151202121918.GA4523@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Please take a look at the following prototype of sharing the PowerPC
VDSO unmap and remap code with other architectures. I've only hooked
up arm64 to begin with. If folks think this is a reasonable approach I
can work on 32 bit ARM as well. Not hearing back from an earlier
request for guidance [1], I simply dove in and started hacking.
Laurent's test case [2][3] is a compelling illustration of whether VDSO
remap works or not on a given architecture.

1. https://lkml.org/lkml/2016/3/2/225
2. https://lists.openvz.org/pipermail/criu/2015-March/019161.html
3. http://lists.openvz.org/pipermail/criu/attachments/20150318/f02ed9ea/attachment.bin

Thanks,
Christopher Covington
