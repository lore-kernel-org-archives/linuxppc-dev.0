Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 905C7B707C
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jun 2010 06:42:43 +1000 (EST)
Subject: Re: [PATCH] kvm/ppc: fix build warning
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20100624194415.GA24107@hera.kernel.org>
Date: Thu, 24 Jun 2010 22:42:35 +0200
Message-Id: <B5C3D944-F5D4-4DC1-BB7D-699CE10EDC15@suse.de>
References: <20100624194415.GA24107@hera.kernel.org>
To: Denis Kirjanov <dkirjanov@hera.kernel.org>
Cc: mtosatti@redhat.com, avi@redhat.com, kvm-ppc@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 24.06.2010, at 21:44, Denis Kirjanov wrote:

> Fix build warning:
> arch/powerpc/kvm/book3s_64_mmu.c: In function =
'kvmppc_mmu_book3s_64_esid_to_vsid':
> arch/powerpc/kvm/book3s_64_mmu.c:446: warning: 'slb' may be used =
uninitialized in this function
> Signed-off-by: Denis Kirjanov <dkirjanov@kernel.org>

Are you sure this isn't a broken compiler? I don't see where it could be =
used uninitialized.


Alex
