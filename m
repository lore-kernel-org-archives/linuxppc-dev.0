Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DC5A12C04F4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2012 04:29:25 +1100 (EST)
Date: Thu, 11 Oct 2012 12:28:56 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: linux-next: manual merge of the kvm-ppc tree with the
 powerpc-merge tree
To: Timur Tabi <B04825@freescale.com>
References: <20121011121841.1b946f996cba995d9a5a2be7@canb.auug.org.au>
 <6AE080B68D46FC4BA2D2769E68D765B7080FA8F8@039-SN2MPN1-023.039d.mgd.msft.net>
 <20121011134754.2e2cbb24842fa991e61cf97c@canb.auug.org.au>
 <6AE080B68D46FC4BA2D2769E68D765B7080FA9F8@039-SN2MPN1-023.039d.mgd.msft.net>
 <6201AAAD-F575-4D2C-9A97-3EB41DA3491C@suse.de>
 <5076EBFE.5060208@freescale.com> <1349973438.6903.4@snotra>
 <507700EB.5090307@freescale.com>
In-Reply-To: <507700EB.5090307@freescale.com> (from B04825@freescale.com on
 Thu Oct 11 12:24:59 2012)
Message-ID: <1349976536.6903.7@snotra>
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

On 10/11/2012 12:24:59 PM, Timur Tabi wrote:
> Scott Wood wrote:
> >> > My concern is that when I think of a user-space header file, I =20
> think
> >> > of a
> >> > user-space application that calls ioctls.  I know that KVM guest
> >> > kernels
> >> > run as user-space processes, but that does not seem like a =20
> reason to
> >> > combine all of the header files that the KVM guest kernel needs =20
> with
> >> > "real" user-space header files.
>=20
> > So where should guest headers go?
>=20
> I admit that I don't have any answers, especially since this whole =20
> thing
> is new to me.  Like I said, I don't know much about KVM internals, so =20
> I
> just don't understand why KVM guests need to have access to these =20
> kernel
> header files as if they're user header files.  The guests are still =20
> Linux
> kernels (or other OSes that think they're running as privileged code).

For hypercalls and other paravirt.  That's the point -- they're not =20
kernel headers.  They're guest API headers.

-scott=
