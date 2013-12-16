Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id CF9702C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Dec 2013 12:27:33 +1100 (EST)
Date: Sun, 15 Dec 2013 20:27:25 -0500 (EST)
Message-Id: <20131215.202725.1549146673897801643.davem@davemloft.net>
To: msalter@redhat.com
Subject: Re: [PATCH 10/10] Kconfig: cleanup SERIO_I8042 dependencies
From: David Miller <davem@davemloft.net>
In-Reply-To: <1387122626.1979.136.camel@deneb.redhat.com>
References: <52ACA43F.2040402@zytor.com>
 <20131215103657.GB20197@core.coreip.homeip.net>
 <1387122626.1979.136.camel@deneb.redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, paulus@samba.org, hpa@zytor.com,
 sparclinux@vger.kernel.org, gxt@mprc.pku.edu.cn, linux@arm.linux.org.uk,
 x86@kernel.org, mingo@redhat.com, fenghua.yu@intel.com, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, rth@twiddle.net, tony.luck@intel.com,
 dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, ralf@linux-mips.org,
 lethal@linux-sh.org, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mark Salter <msalter@redhat.com>
Date: Sun, 15 Dec 2013 10:50:26 -0500

> On Sun, 2013-12-15 at 02:36 -0800, Dmitry Torokhov wrote:
>> How are we going to merge this? In bulk through input tree or peacemeal
>> through all arches first?
>
> They should all go together to eliminate the chance of bisect breakage.
> Either the input tree or maybe akpm tree.

This sounds good to me.
