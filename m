Return-Path: <B04825@freescale.com>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe005.messaging.microsoft.com
 [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4F232B6EF1
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 13:45:44 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Li Yang-R58472 <r58472@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: allow CONFIG_PHYS_64BIT to be selectable
Date: Fri, 24 Feb 2012 02:45:36 +0000
Message-ID: <4F46F9CF.6040600@freescale.com>
References: <1329853995-7533-1-git-send-email-timur@freescale.com>
 <110EED8CC96DFC488B7E717A2027A27C02C5E8@039-SN1MPN1-002.039d.mgd.msft.net>
 <4F463006.7060507@freescale.com>
 <110EED8CC96DFC488B7E717A2027A27C02E4A8@039-SN1MPN1-002.039d.mgd.msft.net>
 <94F013E7935FF44C83EBE7784D62AD3F0578CD9A@039-SN2MPN1-023.039d.mgd.msft.net>
In-Reply-To: <94F013E7935FF44C83EBE7784D62AD3F0578CD9A@039-SN2MPN1-023.039d.mgd.msft.net>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Huang Changming-R66093 <r66093@freescale.com>,
 Wood Scott-B07421 <B07421@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Li Yang-R58472 wrote:

> I agree with Changming that we shouldn't setting PHYS_64BIT by default.

The default kernel should always be the compatible with as much as=20
possible.  Disabling PHYS_64BIT by default means that the default kernel=20
will not work with a 36-bit DTS.  If you attempt to boot such a kernel=20
with a 36-bit DTS, there will be no text output.  Most people will not=20
know why it's not working.

So the safest option is for PHYS_64BIT to be enabled by default.  That=20
way, the kernel will always work.

--=20
Timur Tabi
Linux kernel developer at Freescale=
