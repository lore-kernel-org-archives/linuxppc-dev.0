Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4E2DA2C0417
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2012 03:37:26 +1100 (EST)
Date: Thu, 11 Oct 2012 11:37:18 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: linux-next: manual merge of the kvm-ppc tree with the
 powerpc-merge tree
To: Timur Tabi <B04825@freescale.com>
References: <20121011121841.1b946f996cba995d9a5a2be7@canb.auug.org.au>
 <6AE080B68D46FC4BA2D2769E68D765B7080FA8F8@039-SN2MPN1-023.039d.mgd.msft.net>
 <20121011134754.2e2cbb24842fa991e61cf97c@canb.auug.org.au>
 <6AE080B68D46FC4BA2D2769E68D765B7080FA9F8@039-SN2MPN1-023.039d.mgd.msft.net>
 <6201AAAD-F575-4D2C-9A97-3EB41DA3491C@suse.de>
 <5076EBFE.5060208@freescale.com>
In-Reply-To: <5076EBFE.5060208@freescale.com> (from B04825@freescale.com on
 Thu Oct 11 10:55:42 2012)
Message-ID: <1349973438.6903.4@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
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

On 10/11/2012 10:55:42 AM, Timur Tabi wrote:
> Alexander Graf wrote:
>=20
>=20
> > This is about kvm_host.h, which is the part that is exported to user
> > space. It usually contains constants and structs that are required =20
> for
> > the API.
>=20
> Which API?  I'm not familiar with KVM internals.
>=20
> My concern is that when I think of a user-space header file, I think =20
> of a
> user-space application that calls ioctls.  I know that KVM guest =20
> kernels
> run as user-space processes, but that does not seem like a reason to
> combine all of the header files that the KVM guest kernel needs with
> "real" user-space header files.

So where should guest headers go?

-Scott=
