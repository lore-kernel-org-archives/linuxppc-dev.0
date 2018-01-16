Return-Path: <catalin.marinas@arm.com>
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zLQ1s6W3szF0YY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 20:30:41 +1100 (AEDT)
Date: Tue, 16 Jan 2018 09:30:29 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: tglx@linutronix.de, john.stultz@linaro.org,
 linux-kernel@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org,
 acme@kernel.org, benh@kernel.crashing.org, borntraeger@de.ibm.com,
 cmetcalf@mellanox.com, cohuck@redhat.com, davem@davemloft.net,
 deller@gmx.de, devel@driverdev.osuosl.org,
 gerald.schaefer@de.ibm.com, gregkh@linuxfoundation.org,
 heiko.carstens@de.ibm.com, hoeppner@linux.vnet.ibm.com,
 hpa@zytor.com, jejb@parisc-linux.org, jwi@linux.vnet.ibm.com,
 linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 mark.rutland@arm.com, mingo@redhat.com, mpe@ellerman.id.au,
 oberpar@linux.vnet.ibm.com, oprofile-list@lists.sf.net,
 paulus@samba.org, peterz@infradead.org, ralf@linux-mips.org,
 rostedt@goodmis.org, rric@kernel.org, schwidefsky@de.ibm.com,
 sebott@linux.vnet.ibm.com, sparclinux@vger.kernel.org,
 sth@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com,
 will.deacon@arm.com, x86@kernel.org
Subject: Re: [PATCH v3 02/10] include: Move compat_timespec/ timeval to
 compat_time.h
Message-ID: <20180116093029.gzse6xs4sjx43znp@armageddon.cambridge.arm.com>
References: <20180116021818.24791-1-deepa.kernel@gmail.com>
 <20180116021818.24791-3-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180116021818.24791-3-deepa.kernel@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 15, 2018 at 06:18:10PM -0800, Deepa Dinamani wrote:
> All the current architecture specific defines for these
> are the same. Refactor these common defines to a common
> header file.
> 
> The new common linux/compat_time.h is also useful as it
> will eventually be used to hold all the defines that
> are needed for compat time types that support non y2038
> safe types. New architectures need not have to define these
> new types as they will only use new y2038 safe syscalls.
> This file can be deleted after y2038 when we stop supporting
> non y2038 safe syscalls.

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
