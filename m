Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
 [65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id E9397B6F9C
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Nov 2011 10:49:36 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC][PATCH 15/30] powerpc/85xx: Rework P1022DS device tree
Date: Tue, 15 Nov 2011 23:49:00 +0000
Message-ID: <CAOZdJXU6NXgWv=VwShOvEGH5rm0KJmrQgOCVDiSJtKoVMs5=eg@mail.gmail.com>
References: <1320941653-29797-1-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-2-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-3-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-4-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-5-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-6-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-7-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-8-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-9-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-10-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-11-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-12-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-13-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-14-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-15-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-16-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1320941653-29797-16-git-send-email-galak@kernel.crashing.org>
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

On Thu, Nov 10, 2011 at 10:13 AM, Kumar Gala <galak@kernel.crashing.org> wr=
ote:
>
> + =A0 =A0 =A0 lbc: localbus@fffe05000 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0 0xffe05000 0 0x1000>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <19 2 0 0>;

I just noticed this bug in the original p1022ds.dts, and I see you're
carrying it over here.  The reg property should look like this:

reg =3D <0xf 0xffe05000 0 0x1000>;
       ^^^

Do you want to fix this here, or do you want me to submit a patch that
fixes the original p1022ds.dts?

--=20
Timur Tabi
Linux kernel developer at Freescale=
