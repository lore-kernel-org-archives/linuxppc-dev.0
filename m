Return-Path: <galak@kernel.crashing.org>
Subject: Re: PCI EDAC on MPC85xx
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20110531131737.GA29164@doriath.ww600.siemens.net>
Date: Tue, 31 May 2011 13:41:04 -0500
Message-Id: <7373D079-743D-4D49-BDC6-2BEAF14C43DF@kernel.crashing.org>
References: <20110531131737.GA29164@doriath.ww600.siemens.net>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 31, 2011, at 8:17 AM, Dmitry Eremin-Solenikov wrote:

> Hello,
>=20
> Long time ago (around July of 2010), I've reported a problem of =
binding
> pci error reporting driver to the hardware (See
> http://thread.gmane.org/gmane.linux.kernel.edac/181). Grant Likely has
> come with a patch to create platform devices (of_platform at that =
time),
> for device_nodes which have "compatible" properties
> (http://article.gmane.org/gmane.linux.ports.ppc.embedded/36981).
>=20
> The patch was not applied at that time and the problem still arises at
> 3.0-rc1. Should the patch in question be applied, or is there any new
> solution?
> Current version of that patch which I have in my tree is attached
> to this mail (no original signoff by Grant).
>=20
> --=20
> With best wishes
> Dmitry
>=20
> <0001-of-device-Register-children-with-a-compatible-value-.patch>

I think the desired solution here was to create a new node in the =
fsl_pci code that the edac code would bind against.

- k=
