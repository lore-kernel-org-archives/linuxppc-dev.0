Return-Path: <B04825@freescale.com>
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Robert Sciuk <robert.sciuk@exfo.com>
Subject: Re: fpga driver on custom PPC target platform (P4080) ...
Date: Fri, 4 Nov 2011 16:36:42 +0000
Message-ID: <CAOZdJXWjS4t9cOKRB3rxy0iCFAYRyEgg6kfQwvydUQSyO1ttoA@mail.gmail.com>
References: <2DD52030B5146141BEB762A11AE97C4C0100C735@SPQCEXC05.exfo.com>
In-Reply-To: <2DD52030B5146141BEB762A11AE97C4C0100C735@SPQCEXC05.exfo.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "devicetree-discuss@lists.ozlabs.org"
 <devicetree-discuss@lists.ozlabs.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 3, 2011 at 5:12 PM, Robert Sciuk <robert.sciuk@exfo.com> wrote:

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lim_r: gpio@e8 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible=
 =3D "nxp,pca9539";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0=
xe8>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#gpio-cell=
s =3D <2>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpio-contr=
oller;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0polarity =
=3D <0x00>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lim_w: gpio@e9 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible=
 =3D "nxp,pca9539";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0=
xe9>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#gpio-cell=
s =3D <2>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpio-contr=
oller;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0polarity =
=3D <0x00>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>
> It appears that I'm not correctly creating the pca9539 nodes as of yet (I=
'll be adding the phandles shortly). =A0Any pointers for pca9539 driver nod=
es would be appreciated, as I took these from a similar tree, but not the 9=
5xx driver. =A0I'll match them up with the code in the morning ...

I *believe* you are not supposed to create separate nodes for reading
and writing.  I know that's how I2C works, but I think the I2C layer
takes care of that for you.

If you look at other device trees, you'll see they only have one node
for any particular I2C device.

--=20
Timur Tabi
Linux kernel developer at Freescale=
