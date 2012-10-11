Return-Path: <B04825@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 75F912C007C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 12:47:21 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the kvm-ppc tree with the
 powerpc-merge tree
Date: Thu, 11 Oct 2012 01:47:13 +0000
Message-ID: <6AE080B68D46FC4BA2D2769E68D765B7080FA8F8@039-SN2MPN1-023.039d.mgd.msft.net>
References: <20121011121841.1b946f996cba995d9a5a2be7@canb.auug.org.au>
In-Reply-To: <20121011121841.1b946f996cba995d9a5a2be7@canb.auug.org.au>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Alexander Graf <agraf@suse.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Howells <dhowells@redhat.com>,
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 10, 2012 at 8:18 PM, Stephen Rothwell <sfr@canb.auug.org.au> wr=
ote:

>  arch/powerpc/include/asm/epapr_hcalls.h      |  511 --------------------=
------
>  arch/powerpc/include/uapi/asm/Kbuild         |    1 +
>  arch/powerpc/include/uapi/asm/epapr_hcalls.h |  511 ++++++++++++++++++++=
++++++

What is include/uapi?  epapr_hcalls.h is not a user-space header file.
 I don't remember seeing the original patch which moved it, so I don't
know where this comes from.


--=20
Timur Tabi
Linux kernel developer at Freescale=
