Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qdq544RCSzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Apr 2016 21:09:44 +1000 (AEST)
Message-ID: <1459768184.3260.14.camel@neuling.org>
Subject: Re: PR KVM and TM issues
From: Michael Neuling <mikey@neuling.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Anton Blanchard <anton@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Mon, 04 Apr 2016 21:09:44 +1000
In-Reply-To: <57021123.6050506@ozlabs.ru>
References: <20160404164457.539a55f0@kryten> <57021123.6050506@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-04-04 at 17:00 +1000, Alexey Kardashevskiy wrote:
> On 04/04/2016 04:44 PM, Anton Blanchard wrote:
> > Hi,
> >=20
> > I can't get an Ubuntu Wily guest to boot on an Ubuntu Wily host in PR K=
VM
> > mode. The kernel in both cases is 4.2. To reproduce:
> >=20
> > wget -N https://cloud-images.ubuntu.com/wily/current/wily-server-cloudi=
mg-ppc64el-disk1.img
> >=20
> > qemu-system-ppc64 -cpu POWER8 -enable-kvm -machine pseries,kvm-type=3DP=
R -m 4G -nographic -vga none -drive file=3Dwily-server-cloudimg-ppc64el-dis=
k1.img,if=3Dvirtio
> >=20
> > Should TM work inside a PR KVM guest?
>=20
> If I read the kernel code correctly (kvmppc_set_one_reg_hv vs.=20
> kvmppc_set_one_reg_pr), no, it should not be expected to work.

What's missing?

Mikey
