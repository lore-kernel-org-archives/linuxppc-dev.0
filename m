Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DE83DB71BB
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Aug 2011 03:26:26 +1000 (EST)
Subject: Re: [PATCH v10 5/5] [powerpc] Fix up fsl-flexcan device tree binding.
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20110810172040.GX4926@sgi.com>
Date: Wed, 10 Aug 2011 12:26:17 -0500
Message-Id: <37458316-F50D-4E4A-A59B-01CB8A6FC108@kernel.crashing.org>
References: <1312945564-6626-1-git-send-email-holt@sgi.com>
	<1312945564-6626-6-git-send-email-holt@sgi.com>
	<4E428BFF.7060402@grandegger.com> <20110810141550.GQ4926@sgi.com>
	<9C64B7751C3BCA41B64A68E23005A7BE1C6A21@039-SN1MPN1-002.039d.mgd.msft.net>
	<20110810160054.GT4926@sgi.com>
	<63306A24-3FBF-4DAA-A0B9-6005F56BB76F@kernel.crashing.org>
	<20110810171600.GV4926@sgi.com>
	<8C9817C6-735D-4B7C-A03B-5661C04C725A@kernel.crashing.org>
	<20110810172040.GX4926@sgi.com>
To: Robin Holt <holt@sgi.com>
Cc: "socketcan-core@lists.berlios.de" <socketcan-core@lists.berlios.de>,
	Wood Scott-B07421 <B07421@freescale.com>,
	U Bhaskar-B22300 <B22300@freescale.com>,
	PPC list <linuxppc-dev@lists.ozlabs.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>>>>> So the node names should be
>>>>>>> 		can@1c000 {
>>>>>>> 		can@1d000 {
>>>>>>> correct?
>>>>>>>=20
>>>>>> [Bhaskar] As there are two CAN controllers on P1010,So won't it =
be better
>>>>>> 	    to distinguish it by can0 and can1 instead by simple "can" ?
>>>>>=20
>>>>> It looks like the way to do that is to assign a label to those =
devices
>>>>> and then associate the label with an alias.  I have no idea how =
that
>>>>> works under the hood, but it is the way other files are set up.  =
Take a
>>>>> look at arch/powerpc/boot/dts/bamboo.dts for how they define the =
serial
>>>>> interfaces.
>>>>>=20
>>>>> Grant or Wolfgang, is that the right way to handle the concern =
about
>>>>> names or does it have no practical effect with the Linux kernel?
>>>>=20
>>>> It has not effect.  The label is just if you need to reference it =
via some other means.
>>>=20
>>> Does the alias have an effect?
>>=20
>> nope
>=20
> Then how does the device number get associated with a particular =
device

What do you mean by device number?

> and how is user-space ensured a consistent namespace?

that is left to udev rules.

- k=
