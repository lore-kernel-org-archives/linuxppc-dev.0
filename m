Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B8F492C007B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2012 08:11:49 +1000 (EST)
Message-ID: <1347574295.2276.34.camel@pasglop>
Subject: Re: [PATCH] powerpc/smp: Do not disable IPI interrupts during suspend
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Date: Fri, 14 Sep 2012 08:11:35 +1000
In-Reply-To: <287921FF-96B1-4BBC-B9F9-3F8D24244061@kernel.crashing.org>
References: <1342788421-27648-1-git-send-email-chenhui.zhao@freescale.com>
 <5028672F-1873-4E45-AA23-4CA9F191BE77@kernel.crashing.org>
 <1343427631.21647.1.camel@pasglop>
 <20120802100418.GA13777@localhost.localdomain>
 <1C2FF4B5-3F3C-4A9D-941D-A4BC4F5C95DE@kernel.crashing.org>
 <287921FF-96B1-4BBC-B9F9-3F8D24244061@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 Zhao Chenhui <chenhui.zhao@freescale.com>, "linux-kernel@vger.kernel.org
 list" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-09-13 at 13:16 -0500, Kumar Gala wrote:
> >> Yes, we disabled all non-boot CPUs on suspend by calling
> disable_nonboot_cpus().
> >> The disable_nonboot_cpus() needs IPIs to work. But prior to
> >> calling disable_nonboot_cpus(), the IPIs are disabled in
> dpm_suspend_noirq().

Sure, no biggie on this one, forgot to ack it, just stick my ack in and
put it in your tree.

Cheers,
Ben.
