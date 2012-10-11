Return-Path: <B04825@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 348ED2C05E1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2012 04:31:00 +1100 (EST)
Message-ID: <5077024A.9010209@freescale.com>
Date: Thu, 11 Oct 2012 12:30:50 -0500
From: Timur Tabi <B04825@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: linux-next: manual merge of the kvm-ppc tree with the
 powerpc-merge tree
References: <20121011121841.1b946f996cba995d9a5a2be7@canb.auug.org.au>
 <6AE080B68D46FC4BA2D2769E68D765B7080FA8F8@039-SN2MPN1-023.039d.mgd.msft.net>
 <20121011134754.2e2cbb24842fa991e61cf97c@canb.auug.org.au>
 <6AE080B68D46FC4BA2D2769E68D765B7080FA9F8@039-SN2MPN1-023.039d.mgd.msft.net>
 <6201AAAD-F575-4D2C-9A97-3EB41DA3491C@suse.de>
 <5076EBFE.5060208@freescale.com> <1349973438.6903.4@snotra>
 <507700EB.5090307@freescale.com> <1349976536.6903.7@snotra>
In-Reply-To: <1349976536.6903.7@snotra>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Alexander Graf <agraf@suse.de>,
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

Scott Wood wrote:
> For hypercalls and other paravirt.  That's the point -- they're not  
> kernel headers.  They're guest API headers.

Well, IMHO, guest API != user-space.  Maybe we should have a parallel
mechanism to uapi to make the kvm guest header files available.

-- 
Timur Tabi
Linux kernel developer at Freescale
