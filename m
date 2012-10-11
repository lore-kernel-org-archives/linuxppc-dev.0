Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E2B422C0089
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2012 00:05:09 +1100 (EST)
Subject: Re: linux-next: manual merge of the kvm-ppc tree with the
 powerpc-merge tree
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=iso-8859-1
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <6AE080B68D46FC4BA2D2769E68D765B7080FA9F8@039-SN2MPN1-023.039d.mgd.msft.net>
Date: Thu, 11 Oct 2012 15:04:58 +0200
Message-Id: <6201AAAD-F575-4D2C-9A97-3EB41DA3491C@suse.de>
References: <20121011121841.1b946f996cba995d9a5a2be7@canb.auug.org.au>
 <6AE080B68D46FC4BA2D2769E68D765B7080FA8F8@039-SN2MPN1-023.039d.mgd.msft.net>
 <20121011134754.2e2cbb24842fa991e61cf97c@canb.auug.org.au>
 <6AE080B68D46FC4BA2D2769E68D765B7080FA9F8@039-SN2MPN1-023.039d.mgd.msft.net>
To: Tabi Timur-B04825 <B04825@freescale.com>
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


On 11.10.2012, at 05:32, Tabi Timur-B04825 wrote:

> On Wed, Oct 10, 2012 at 9:47 PM, Stephen Rothwell =
<sfr@canb.auug.org.au> wrote:
>=20
>> Commit 549d62d889b4 ("KVM: PPC: use definitions in epapr header
>> for hcalls") from the kvm-ppc tree added an include of =
asm/epapr_hcall.h
>> to the user visible part of asm/kvm_para.h so asm/epapr_hcall.h =
became a
>> user visible header file.
>=20
> Any real user-space code that tries to call any of the functions in
> epapr_hcall.h will cause an exception.
>=20
> Claiming that kernel header files that KVM needs are suddenly
> user-space header files doesn't make much sense to me, but I guess
> it's not my decision.

This is about kvm_host.h, which is the part that is exported to user =
space. It usually contains constants and structs that are required for =
the API.


Alex
