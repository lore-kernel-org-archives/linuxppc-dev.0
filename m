Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id BE0AC2C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jul 2013 11:00:25 +1000 (EST)
Subject: Re: [PATCH 0/2] powerpc: allow kvm to use kerel debug framework
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1372918546-15075-1-git-send-email-Bharat.Bhushan@freescale.com>
Date: Tue, 9 Jul 2013 03:00:16 +0200
Message-Id: <C4D71A1A-3D5B-4C9C-A26B-9EAFFD9D87C5@suse.de>
References: <1372918546-15075-1-git-send-email-Bharat.Bhushan@freescale.com>
To: Bharat Bhushan <r65777@freescale.com>
Cc: mikey@neuling.org, linux-kernel@vger.kernel.org,
 Bharat Bhushan <bharat.bhushan@freescale.com>, scottwood@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 04.07.2013, at 08:15, Bharat Bhushan wrote:

> From: Bharat Bhushan <bharat.bhushan@freescale.com>
>=20
> This patchset moves the debug registers in a structure, which allows
> kvm to use same structure for debug emulation.
>=20
> Note: Earilier a patchset =
"https://lists.ozlabs.org/pipermail/linuxppc-dev/2013-June/108132.html"
> was sent which is a bunch of six patches. That patchset is divided =
into two parts:
> 	1) powerpc specific changes (These 2 patches are actually have =
those changes)
> 	2) KVM specific changes (will send separate patch on agraf =
repository)

Mikey, if you like those could you please apply the into a topic branch =
and get that one merged with Ben? I'd also pull it into my tree then.


Alex

>=20
> Bharat Bhushan (2):
>  powerpc: remove unnecessary line continuations
>  powerpc: move debug registers in a structure
>=20
> arch/powerpc/include/asm/processor.h |   38 +++++----
> arch/powerpc/include/asm/reg_booke.h |    8 +-
> arch/powerpc/kernel/asm-offsets.c    |    2 +-
> arch/powerpc/kernel/process.c        |   42 +++++-----
> arch/powerpc/kernel/ptrace.c         |  154 =
+++++++++++++++++-----------------
> arch/powerpc/kernel/ptrace32.c       |    2 +-
> arch/powerpc/kernel/signal_32.c      |    6 +-
> arch/powerpc/kernel/traps.c          |   35 ++++----
> 8 files changed, 147 insertions(+), 140 deletions(-)
>=20
>=20
