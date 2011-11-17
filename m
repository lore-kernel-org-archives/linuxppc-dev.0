Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1392AB7379
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2011 01:33:18 +1100 (EST)
Subject: Re: [PATCH 21/29] powerpc/85xx: Rework P1022DS device tree
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CAOZdJXU1wdm9dgCDTOTzYUqKvQbB9anhSAJgGMXtypz4gqnuSQ@mail.gmail.com>
Date: Thu, 17 Nov 2011 08:33:11 -0600
Message-Id: <490D0644-AC5D-4B24-B217-80EE65EF4672@kernel.crashing.org>
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
 <1321514181-28897-16-git-send-email-galak! @kernel.crashing.org>
 <1321514181-28897-17-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-18-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-19-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-20-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-21-git-send-email-galak@kernel.crashing.org>
 <CAOZdJXU1wdm9dgCDTOTzYUqKvQbB9anhSAJgGMXtypz4gqnuSQ@mail.gmail.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 17, 2011, at 8:01 AM, Tabi Timur-B04825 wrote:

> On Thu, Nov 17, 2011 at 1:16 AM, Kumar Gala =
<galak@kernel.crashing.org> wrote:
>=20
>> -       localbus@fffe05000 {
>> -               #address-cells =3D <2>;
>> -               #size-cells =3D <1>;
>> -               compatible =3D "fsl,p1022-elbc", "fsl,elbc", =
"simple-bus";
>> +       lbc: localbus@fffe05000 {
>>                reg =3D <0 0xffe05000 0 0x1000>;
>> -               interrupts =3D <19 2 0 0>;
>=20
> The 'reg' property is still wrong.  It should be <0xf 0xffe05000 0 =
0x1000>;

thanks, fixed.

- k=
