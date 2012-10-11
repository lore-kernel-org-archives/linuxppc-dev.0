Return-Path: <B04825@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C2F3B2C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2012 02:55:50 +1100 (EST)
Message-ID: <5076EBFE.5060208@freescale.com>
Date: Thu, 11 Oct 2012 10:55:42 -0500
From: Timur Tabi <B04825@freescale.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: linux-next: manual merge of the kvm-ppc tree with the
 powerpc-merge tree
References: <20121011121841.1b946f996cba995d9a5a2be7@canb.auug.org.au>
 <6AE080B68D46FC4BA2D2769E68D765B7080FA8F8@039-SN2MPN1-023.039d.mgd.msft.net>
 <20121011134754.2e2cbb24842fa991e61cf97c@canb.auug.org.au>
 <6AE080B68D46FC4BA2D2769E68D765B7080FA9F8@039-SN2MPN1-023.039d.mgd.msft.net>
 <6201AAAD-F575-4D2C-9A97-3EB41DA3491C@suse.de>
In-Reply-To: <6201AAAD-F575-4D2C-9A97-3EB41DA3491C@suse.de>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
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

Alexander Graf wrote:


> This is about kvm_host.h, which is the part that is exported to user
> space. It usually contains constants and structs that are required for
> the API.

Which API?  I'm not familiar with KVM internals.

My concern is that when I think of a user-space header file, I think of a
user-space application that calls ioctls.  I know that KVM guest kernels
run as user-space processes, but that does not seem like a reason to
combine all of the header files that the KVM guest kernel needs with
"real" user-space header files.

-- 
Timur Tabi
Linux kernel developer at Freescale
