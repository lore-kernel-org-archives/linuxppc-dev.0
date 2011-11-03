Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 7390EB6F70
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2011 22:40:22 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 23093-01 for <linuxppc-dev@lists.ozlabs.org>;
 Thu,  3 Nov 2011 11:40:19 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [PATCH] powerpc/usb: use unsigned long to type cast an address of
 ioremap
Date: Thu, 3 Nov 2011 11:38:48 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AEA3@saturn3.aculab.com>
In-Reply-To: <CAOZdJXW16RbPkMfmoNu4t1c5mqCuZsztPMk1=hNc7NaYXOsx7A@mail.gmail.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Tabi Timur-B04825" <B04825@freescale.com>,
 "Xie Shaohui-B21989" <B21989@freescale.com>
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> On Thu, Nov 3, 2011 at 4:58 AM, Shaohui Xie =
<Shaohui.Xie@freescale.com> wrote:
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usb_sys_regs =3D (struct =
usb_sys_interface *)
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
((u32)dr_regs + USB_DR_SYS_OFFSET);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
((unsigned long)dr_regs + USB_DR_SYS_OFFSET);
>=20
> This makes more sense:
>=20
> usb_sys_regs =3D (void *)dr_regs + USB_DR_SYS_OFFSET;

But that is invalid C.

	David
