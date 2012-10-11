Return-Path: <B04825@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 251FB2C008C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 14:32:54 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the kvm-ppc tree with the
 powerpc-merge tree
Date: Thu, 11 Oct 2012 03:32:46 +0000
Message-ID: <6AE080B68D46FC4BA2D2769E68D765B7080FA9F8@039-SN2MPN1-023.039d.mgd.msft.net>
References: <20121011121841.1b946f996cba995d9a5a2be7@canb.auug.org.au>
 <6AE080B68D46FC4BA2D2769E68D765B7080FA8F8@039-SN2MPN1-023.039d.mgd.msft.net>
 <20121011134754.2e2cbb24842fa991e61cf97c@canb.auug.org.au>
In-Reply-To: <20121011134754.2e2cbb24842fa991e61cf97c@canb.auug.org.au>
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

On Wed, Oct 10, 2012 at 9:47 PM, Stephen Rothwell <sfr@canb.auug.org.au> wr=
ote:

> Commit 549d62d889b4 ("KVM: PPC: use definitions in epapr header
> for hcalls") from the kvm-ppc tree added an include of asm/epapr_hcall.h
> to the user visible part of asm/kvm_para.h so asm/epapr_hcall.h became a
> user visible header file.

Any real user-space code that tries to call any of the functions in
epapr_hcall.h will cause an exception.

Claiming that kernel header files that KVM needs are suddenly
user-space header files doesn't make much sense to me, but I guess
it's not my decision.

--=20
Timur Tabi
Linux kernel developer at Freescale=
