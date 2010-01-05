Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EDD40B6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Jan 2010 00:03:40 +1100 (EST)
Subject: Re: powerpc: allmod config build failure
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20100105143238.ed113985.sfr@canb.auug.org.au>
Date: Tue, 5 Jan 2010 14:03:28 +0100
Message-Id: <04B8CF10-6D9F-477F-8500-043EA0DEBD78@suse.de>
References: <20100105143238.ed113985.sfr@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>, Avi Kivity <avi@redhat.com>,
	Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 05.01.2010, at 04:32, Stephen Rothwell wrote:

> Hi all,
>=20
> The powerpc allmodconfig build of Linus' tree has been failing like =
this
> since Dec 13 (and linux-next since Nov 7):
>=20
> arch/powerpc/kvm/built-in.o:(.toc1+0x18): undefined reference to =
`kvm_debugfs_dir'
>=20
> $ grep KVM .config
> CONFIG_KVM=3Dy
> CONFIG_KVM_BOOK3S_64_HANDLER=3Dy
> CONFIG_KVM_BOOK3S_64=3Dm
> CONFIG_KVM_EXIT_TIMING=3Dy
>=20
> I assume that this failure was introduced by commit
> c4f9c779f1019c7d5c61961a7c0aaaf1420d8f90 ("Include Book3s_64 target in
> buildsystem").

Yes, and the fix is in Avi's tree already =
(1231730604360801d4e648c37c4b98f30850e001).
I'm not sure how the syncing of those two happens - let's ask him.

Alex=
