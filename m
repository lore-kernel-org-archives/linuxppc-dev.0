Return-Path: <tmorrison@empirix.com>
Received: from empbedex1.empirix.com (empbedex1.empirix.com [12.38.203.54])
	by ozlabs.org (Postfix) with ESMTP id 34098DDEFD
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 21:01:39 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Trying to use Device Tree...and getting continuous interrupts
	from attached 88e1145
Date: Mon, 13 Aug 2007 07:01:30 -0400
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D90108D46262@EMPBEDEX.empirix.com>
In-Reply-To: <3A76C14A-4A1C-48FA-9BEA-39020A131084@freescale.com>
References: <BD261180E6D35F4D9D32F3E44FD3D90108BE44C2@EMPBEDEX.empirix.com>
	<3A76C14A-4A1C-48FA-9BEA-39020A131084@freescale.com>
From: "Morrison, Tom" <tmorrison@empirix.com>
To: "Andy Fleming" <afleming@freescale.com>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It turns out that Andy was right and I had not understand the=20
NEW MPIC format for the definition of the external interrupts.
This was different than the 2.6.11++ kernel...

Thank you Ben & Andy for your suggestions, unfortunately,
I had to learn the hard way that it was more fundamental
than I had imagined...

I continue to have problems, but I will itemize those in a
separate email.

Tom Morrison


-----Original Message-----
From: Andy Fleming [mailto:afleming@freescale.com]=20
Sent: Monday, August 06, 2007 2:10 PM
To: Morrison, Tom
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Trying to use Device Tree...and getting continuous
interrupts from attached 88e1145

<Snip>
>>> 		mdio@24520 {
>>> 			#address-cells =3D <1>;
>>> 			#size-cells =3D <0>;
>>> 			device_type =3D "mdio";
>>> 			compatible =3D "gianfar";=09
>>> 			reg =3D <24520 20>;
>>> 			phy1: ethernet-phy@1 {
>>> 				interrupt-parent =3D <&mpic>;
>>> 				interrupts =3D <37 1>;


> How recent of a kernel are you using?  The current kernel assigns=20
> the  external interrupts to be the low 12 interrupts, which would make

> your interrupt assignment wrong.
