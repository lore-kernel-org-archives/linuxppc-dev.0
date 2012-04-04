Return-Path: <galak@kernel.crashing.org>
Subject: Re: [RFC] powerpc/fsl-pci: Document the "fsl,
 has-isa" property for Freescale PCI
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1333263396-23932-1-git-send-email-B38951@freescale.com>
Date: Wed, 4 Apr 2012 08:08:39 -0500
Message-Id: <E3DD739D-1EC3-4BCA-AE26-1EAE7A086A1E@kernel.crashing.org>
References: <1333263396-23932-1-git-send-email-B38951@freescale.com>
To: Jia Hongtao <B38951@freescale.com>
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 1, 2012, at 1:56 AM, Jia Hongtao wrote:

> If PCI is primary bus we should set isa_io/mem_base when parsing PCI =
bridge
> resources from device tree. The previous way to check the primary bus =
based
> on a hard-coded address named primary_phb_addr. Now we add a property =
named
> "fsl,has-isa" into device tree. In kernel we use this property to find =
out
> the bus is primary or not. This way is more flexible.
>=20
> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> .../devicetree/bindings/powerpc/fsl/pci.txt        |   36 =
++++++++++++++++++++
> 1 files changed, 36 insertions(+), 0 deletions(-)
> create mode 100644 =
Documentation/devicetree/bindings/powerpc/fsl/pci.txt

This isn't freescale specific, its linux specific.  If anything the =
property should be linux,has-isa.

But in general I dont think this is a good idea.  In truth one could =
search the device tree for:

	device_type =3D "isa";

to try and set this dynamically.

- k
