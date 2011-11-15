Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 934A0B71FF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2011 13:41:45 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: "Moffett, Kyle D" <Kyle.D.Moffett@boeing.com>
Subject: Re: [RFC PATCH 00/17] powerpc/e500: separate e500 from e500mc
Date: Tue, 15 Nov 2011 02:41:35 +0000
Message-ID: <4EC1D15E.3010800@freescale.com>
References: <4E42AB6F.1050900@freescale.com>
 <1320883399-15911-1-git-send-email-Kyle.D.Moffett@boeing.com>
 <FF2BF3F3-1158-4747-AEEC-03D6A7C462D9@kernel.crashing.org>
 <C0DED343-76A8-457E-BF54-E52DFCAC83A8@boeing.com>
 <58FDDDA5-26C4-493B-A00D-81DD94A5C26A@kernel.crashing.org>
 <20111110165455.GE11983@schlenkerla.am.freescale.net>
 <15AB1C61-181F-4454-AF99-772B73DE0AA5@boeing.com>
 <1320986410.21206.48.camel@pasglop>
 <4A0007C2-1C2C-4162-98E8-ACCA4E673AFE@boeing.com>
In-Reply-To: <4A0007C2-1C2C-4162-98E8-ACCA4E673AFE@boeing.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Moffett, Kyle D wrote:
>the PPC Book-E spec documents that the pagesize is an even multiple
> of the cacheline size and the cachelines are always page-aligned.

cachelines are page aligned?

--=20
Timur Tabi
Linux kernel developer at Freescale=
