Return-Path: <B04825@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CDBB62C009D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2012 22:27:25 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Zhao Chenhui-B35336 <B35336@freescale.com>
Subject: Re: [PATCH 2/4] fsl_pmc: Add API to enable device as wakeup event
 source
Date: Tue, 14 Aug 2012 12:27:17 +0000
Message-ID: <502A4424.80000@freescale.com>
References: <1344329006-10645-1-git-send-email-chenhui.zhao@freescale.com>
 <1344329006-10645-2-git-send-email-chenhui.zhao@freescale.com>
 <CAOZdJXXdgS5x2ZkuXb4wHckdqLzSM2xy-eYU3+28d_=JH3euxg@mail.gmail.com>
 <20120814100141.GB21028@localhost.localdomain>
In-Reply-To: <20120814100141.GB21028@localhost.localdomain>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Li Yang-R58472 <r58472@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Zhao Chenhui-B35336 <B35336@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Zhao Chenhui wrote:
>>> > >+#ifdef CONFIG_FSL_PMC
>>> > >+extern int mpc85xx_pmc_set_wake(struct device *dev, bool enable);
>>> > >+extern void mpc85xx_pmc_set_lossless_ethernet(int enable);
>> >
>> >Don't use 'extern' for functions.
>> >
> Why? I think there is no difference.

It's unnecessary, and it makes the line longer.

--=20
Timur Tabi
Linux kernel developer at Freescale=
