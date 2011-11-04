Return-Path: <robert.sciuk@exfo.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: fpga driver on custom PPC target platform (P4080) ...
Date: Fri, 4 Nov 2011 12:42:48 -0400
Message-ID: <2DD52030B5146141BEB762A11AE97C4C0100C86F@SPQCEXC05.exfo.com>
In-reply-to: <CAOZdJXWjS4t9cOKRB3rxy0iCFAYRyEgg6kfQwvydUQSyO1ttoA@mail.gmail.com>
References: <2DD52030B5146141BEB762A11AE97C4C0100C735@SPQCEXC05.exfo.com>
 <CAOZdJXWjS4t9cOKRB3rxy0iCFAYRyEgg6kfQwvydUQSyO1ttoA@mail.gmail.com>
From: "Robert Sciuk" <robert.sciuk@exfo.com>
To: "Tabi Timur-B04825" <B04825@freescale.com>
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> > It appears that I'm not correctly creating the pca9539 nodes as of
> yet (I'll be adding the phandles shortly). =A0Any pointers for pca9539
> driver nodes would be appreciated, as I took these from a similar =
tree,
> but not the 95xx driver. =A0I'll match them up with the code in the
> morning ...
>=20
> I *believe* you are not supposed to create separate nodes for reading
> and writing.  I know that's how I2C works, but I think the I2C layer
> takes care of that for you.
>=20
> If you look at other device trees, you'll see they only have one node
> for any particular I2C device.
>=20
> --
> Timur Tabi
> Linux kernel developer at Freescale


Thanks, Timur ... I've fixed the tree, and I'm tracking down the =
problems with addressing the nodes ...
