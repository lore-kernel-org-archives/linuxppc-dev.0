Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5E249B6F80
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Oct 2011 07:44:04 +1100 (EST)
Subject: Re: [RFC][PATCH 1/2] powerpc/85xx: create dts components to build up
 an SoC
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CAOZdJXWtnBB5=DahG8LGQpeP7or0VZv78duhtPiORk3WOir8gQ@mail.gmail.com>
Date: Thu, 20 Oct 2011 15:44:11 -0500
Message-Id: <A54F7698-A96F-4EE1-89DB-B6A7C5A071FB@kernel.crashing.org>
References: <1319095467-6229-1-git-send-email-galak@kernel.crashing.org>
 <CAOZdJXWtnBB5=DahG8LGQpeP7or0VZv78duhtPiORk3WOir8gQ@mail.gmail.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 20, 2011, at 11:42 AM, Tabi Timur-B04825 wrote:

> Ok, your other patch makes more sense now.
>=20
> On Thu, Oct 20, 2011 at 2:24 AM, Kumar Gala =
<galak@kernel.crashing.org> wrote:
>=20
>> +++ b/arch/powerpc/boot/dts/fsl/pq3-duart-0.dtsi
>> @@ -0,0 +1,8 @@
>> +&serial0 {
>> +       cell-index =3D <0>;
>> +       device_type =3D "serial";
>> +       compatible =3D "ns16550";
>> +       reg =3D <0x4500 0x100>;
>> +       clock-frequency =3D <0>;
>> +       interrupts =3D <42 2 0 0>;
>> +};
>=20
> How about we put all serial devices into one pq3-duart.dtsi file, and
> let the parent dtsi file reference just the ones that it needs?

there isn't an option to do that w/dtc

- k=
