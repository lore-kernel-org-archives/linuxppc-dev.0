Return-Path: <dmitry.torokhov@gmail.com>
Received: from mail-pd0-x22b.google.com (mail-pd0-x22b.google.com
 [IPv6:2607:f8b0:400e:c02::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F3AEE2C009F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Dec 2013 15:59:19 +1100 (EST)
Received: by mail-pd0-f171.google.com with SMTP id z10so4842529pdj.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Dec 2013 20:59:10 -0800 (PST)
Date: Sun, 15 Dec 2013 20:59:00 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 10/10] Kconfig: cleanup SERIO_I8042 dependencies
Message-ID: <20131216045859.GA4322@core.coreip.homeip.net>
References: <52ACA43F.2040402@zytor.com>
 <20131215103657.GB20197@core.coreip.homeip.net>
 <1387122626.1979.136.camel@deneb.redhat.com>
 <20131215.202725.1549146673897801643.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131215.202725.1549146673897801643.davem@davemloft.net>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, paulus@samba.org, hpa@zytor.com,
 sparclinux@vger.kernel.org, gxt@mprc.pku.edu.cn, linux@arm.linux.org.uk,
 x86@kernel.org, mingo@redhat.com, msalter@redhat.com, fenghua.yu@intel.com,
 tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, rth@twiddle.net,
 tony.luck@intel.com, linux-kernel@vger.kernel.org, ralf@linux-mips.org,
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

On Sun, Dec 15, 2013 at 08:27:25PM -0500, David Miller wrote:
> From: Mark Salter <msalter@redhat.com>
> Date: Sun, 15 Dec 2013 10:50:26 -0500
> 
> > On Sun, 2013-12-15 at 02:36 -0800, Dmitry Torokhov wrote:
> >> How are we going to merge this? In bulk through input tree or peacemeal
> >> through all arches first?
> >
> > They should all go together to eliminate the chance of bisect breakage.
> > Either the input tree or maybe akpm tree.
> 
> This sounds good to me.

OK, then I'll pick it up once I collect more acks from the arch
maintainers.

-- 
Dmitry
