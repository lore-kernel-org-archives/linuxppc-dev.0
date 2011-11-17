Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE010.bigfish.com (tx2ehsobe005.messaging.microsoft.com
 [65.55.88.15]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id A1EACB71FF
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2011 01:01:16 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 21/29] powerpc/85xx: Rework P1022DS device tree
Date: Thu, 17 Nov 2011 14:01:08 +0000
Message-ID: <CAOZdJXU1wdm9dgCDTOTzYUqKvQbB9anhSAJgGMXtypz4gqnuSQ@mail.gmail.com>
References: <1321514181-28897-1-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-2-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-3-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-4-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-5-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-6-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-7-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-8-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-9-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-10-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-11-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-12-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-13-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-14-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-15-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-16-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-17-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-18-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-19-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-20-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-21-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1321514181-28897-21-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 17, 2011 at 1:16 AM, Kumar Gala <galak@kernel.crashing.org> wro=
te:

> - =A0 =A0 =A0 localbus@fffe05000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <2>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,p1022-elbc", "fsl,elbc"=
, "simple-bus";
> + =A0 =A0 =A0 lbc: localbus@fffe05000 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0 0xffe05000 0 0x1000>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <19 2 0 0>;

The 'reg' property is still wrong.  It should be <0xf 0xffe05000 0 0x1000>;

--=20
Timur Tabi
Linux kernel developer at Freescale=
