Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id C214DB70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Jan 2011 08:09:42 +1100 (EST)
Subject: Re: [PATCH] KVM: PPC: Fix SPRG get/set for Book3S and BookE
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1293652285-13313-1-git-send-email-ptyser@xes-inc.com>
Date: Tue, 4 Jan 2011 22:09:38 +0100
Message-Id: <BFFB6065-C605-44A2-9400-9340203C68F6@suse.de>
References: <1293652285-13313-1-git-send-email-ptyser@xes-inc.com>
To: Peter Tyser <ptyser@xes-inc.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


On 29.12.2010, at 20:51, Peter Tyser wrote:

> Previously SPRGs 4-7 were improperly read and written in
> kvm_arch_vcpu_ioctl_get_regs() and kvm_arch_vcpu_ioctl_set_regs();
>=20
> Signed-off-by: Peter Tyser <ptyser@xes-inc.com>

Thanks a lot for the catch. At least for Book3S we don't support SPRGs > =
3 anyways, so it's not really too bad of a glitch. It's irritating =
nevertheless :).

Marcelo/Avi, please include this patch in the kvm tree.

Signed-off-by: Alexander Graf <agraf@suse.de>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.16 (Darwin)

iEYEARECAAYFAk0jjJIACgkQq7Wi27wfN1PIMwCfffOOFsI5K6LXi5AYBUcwK07Q
dGoAn21M9Brz8vxpXxHFNs1QhGOuPGlo
=3D/b/r
-----END PGP SIGNATURE-----
