Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 44C52B6F10
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jun 2010 19:21:19 +1000 (EST)
Subject: Re: [PATCH] kvm/ppc: fix build warning
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <4C2470AE.6090004@kernel.org>
Date: Fri, 25 Jun 2010 11:21:14 +0200
Message-Id: <766B88E1-EBF5-4C53-BBA3-98F152007FB5@suse.de>
References: <20100624194415.GA24107@hera.kernel.org>
	<B5C3D944-F5D4-4DC1-BB7D-699CE10EDC15@suse.de>
	<4C2470AE.6090004@kernel.org>
To: Denis Kirjanov <dkirjanov@kernel.org>
Cc: mtosatti@redhat.com, kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Denis Kirjanov <dkirjanov@hera.kernel.org>, avi@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 25.06.2010, at 11:02, Denis Kirjanov wrote:

> On 06/25/2010 12:42 AM, Alexander Graf wrote:
>>=20
>> On 24.06.2010, at 21:44, Denis Kirjanov wrote:
>>=20
>>> Fix build warning:
>>> arch/powerpc/kvm/book3s_64_mmu.c: In function =
'kvmppc_mmu_book3s_64_esid_to_vsid':
>>> arch/powerpc/kvm/book3s_64_mmu.c:446: warning: 'slb' may be used =
uninitialized in this function
>>> Signed-off-by: Denis Kirjanov<dkirjanov@kernel.org>
>>=20
>> Are you sure this isn't a broken compiler? I don't see where it could =
be used uninitialized.
>=20
> I'm using gcc version 4.3.4 (Gentoo 4.3.4 p1.1, pie-10.1.5)
> slb pointer initialized inside conditional branch
> and used later in the case case MSR_DR|MSR_IR
>=20

Oh, I'm apparently looking at completely different code. The same =
function in git://git.kernel.org/pub/scm/virt/kvm/kvm.git is good. Which =
tree did you use?


Alex
