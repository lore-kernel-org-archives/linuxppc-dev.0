Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe004.messaging.microsoft.com
 [65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2EC45B6EEC
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Feb 2012 23:24:55 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Huang Changming-R66093 <r66093@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: allow CONFIG_PHYS_64BIT to be selectable
Date: Thu, 23 Feb 2012 12:24:40 +0000
Message-ID: <4F463006.7060507@freescale.com>
References: <1329853995-7533-1-git-send-email-timur@freescale.com>
 <110EED8CC96DFC488B7E717A2027A27C02C5E8@039-SN1MPN1-002.039d.mgd.msft.net>
In-Reply-To: <110EED8CC96DFC488B7E717A2027A27C02C5E8@039-SN1MPN1-002.039d.mgd.msft.net>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>,
 Wood Scott-B07421 <B07421@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Huang Changming-R66093 wrote:
> I have one similar patch to remove the "select PHYS_64BIT".
> http://patchwork.ozlabs.org/patch/132351/

That one doesn't update the defconfigs, which means that the default=20
kernel will not have PHYS_64BIT enabled.

--=20
Timur Tabi
Linux kernel developer at Freescale=
