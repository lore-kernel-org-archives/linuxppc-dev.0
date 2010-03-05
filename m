Return-Path: <galak@kernel.crashing.org>
Subject: Re: [RFC: PATCH 08/13] powerpc/476: define specific cpu table entry
	for DD1 and DD1.1 cores
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <fb412d761003040906i57842fc3t48693d5e5e777176@mail.gmail.com>
Date: Fri, 5 Mar 2010 03:15:11 -0600
Message-Id: <C84D9A35-C618-47FB-A95C-73B8B940BC7C@kernel.crashing.org>
References: <20100301191255.20987.84668.sendpatchset@norville.austin.ibm.com>
	<20100301191351.20987.49730.sendpatchset@norville.austin.ibm.com>
	<fb412d761003040906i57842fc3t48693d5e5e777176@mail.gmail.com>
To: Hollis Blanchard <hollis@penguinppc.org>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>, Torez Smith <torez@us.ibm.com>,
	Dave Kleikamp <shaggy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 4, 2010, at 11:06 AM, Hollis Blanchard wrote:

> On Mon, Mar 1, 2010 at 11:13 AM, Dave Kleikamp =
<shaggy@linux.vnet.ibm.com> wrote:
> powerpc/476: define specific cpu table entry for DD1 and DD1.1 cores
>=20
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> There are still some unstable bits on the DD1 and DD1.1 cores.  Don't =
use
> the FPU or the tlbivax operation.  Define CPU_FTR_476_DD1 and
> CPU_FTR_476_DD1_1 for additional workarounds in later patches.
>=20
> The DD1 core requires workarounds triggered by both CPU_FTR_476_DD1
> and CPU_FTR_476_DD1_1.  the DD1.1 core only needs CPU_FTR_476_DD1_1
> defined.
>=20
> Isn't the policy generally not to commit workarounds for =
early/errataful hardware which will not be seen in the real world? =
Otherwise, every new half-broken core could burn a bunch of feature =
bits...
>=20
> -Hollis

I'm with Hollis.  Cluttering the code with non-production errata could =
get very ugly as well as burning feature bits up like made.

- k=
