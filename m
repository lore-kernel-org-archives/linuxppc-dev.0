Return-Path: <galak@kernel.crashing.org>
Subject: Re: Proposal to move PCI out of arch/powerpc and into drivers/of
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <27bab769-0788-4b48-96a7-ced65e40144c@SG2EHSMHS007.ehs.local>
Date: Fri, 26 Feb 2010 17:50:26 -0600
Message-Id: <CDF924F6-56F9-4F3D-9CF9-BF321437C3B5@kernel.crashing.org>
References: <27bab769-0788-4b48-96a7-ced65e40144c@SG2EHSMHS007.ehs.local>
To: John Linn <John.Linn@xilinx.com>
Cc: devicetree-discuss@ozlabs.org, michal.simek@petalogix.com,
	microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, John Williams <john.williams@petalogix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 26, 2010, at 5:07 PM, John Linn wrote:

> Hi all,
>=20
> We are in the process of putting PCI/PCIe into the microblaze
> architecture. =20
>=20
> In order to not duplicate/fork the PCI code in Powerpc, we're =
proposing
> to move the PCI code from arch/powerpc into drivers/of such that it
> would be common code for Powerpc and MicroBlaze.
>=20
> This would be the 1st part of a refactoring that would occur with the
> PCI code.
>=20
> Ben H., would you mind if that happened (move arch/powerpc/kernel/pci*
> to drivers/of/*)?
>=20
> Thanks,
> John

John,

Does MicroBlaze firmware produce full OF style PCI device tree's or do =
what we do on embedded systems and just have the root and leave the =
probing to the kernel?  I haven't looked at the OF side of what we do in =
PPC in a while but I know we have some major differences between PPC32 & =
PPC64 because of assumptions about what the firmware provides (or =
doesnt).

As well as features on the PPC64 side to not re-probe PCI and build =
internal kernel data structures purely from the OF tree.

I think moving the code and sharing it between everyone is a good thing, =
just point out some issues I know we are aware of.

- k=
