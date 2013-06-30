Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3110E2C02BF
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jun 2013 14:08:23 +1000 (EST)
Message-ID: <1372565170.18612.87.camel@pasglop>
Subject: Re: [PATCH] powerpc/pci: Avoid overriding MSI interrupt
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Sun, 30 Jun 2013 14:06:10 +1000
In-Reply-To: <20130630015137.GA7919@shangw.(null)>
References: <1372425030-5759-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1372547360.18612.76.camel@pasglop> <20130630015137.GA7919@shangw.(null)>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Yuanquan.Chen@freescale.com, linuxppc-dev@lists.ozlabs.org,
 Guenter Roeck <linux@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-06-30 at 09:51 +0800, Gavin Shan wrote:

> Ben, I think one patch was lost from mainline and that fixes the problem.
> 
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=5fb621698e94e3af8b413d9439041fde48e2784d
> 
> I had the patch applied to /home/benh/linux-test and have following commands
> to inject errors, everything looks good :-)
> 
> errinjct eeh -v -f 0 -p U78AB.001.WZSGBJ6-P1-C5-T1 -a 0x0 -m 0x0
> errinjct eeh -v -f 0 -p U78AB.001.WZSGBJ6-P1-C6-T1 -a 0x0 -m 0x0

Ok, thanks, it's in -next and not upstream yet. I'll ask Linus to pull
that one.

Cheers,
Ben.
