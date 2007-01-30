Return-Path: <tmorrison@empirix.com>
Received: from empbedex1.empirix.com (empbedex1.empirix.com [12.38.203.54])
	by ozlabs.org (Postfix) with ESMTP id 05633DE063
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 10:18:13 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: options for root file system for MPC8548
Date: Tue, 30 Jan 2007 18:14:02 -0500
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D901053E8497@EMPBEDEX.empirix.com>
References: <BD261180E6D35F4D9D32F3E44FD3D901064432D9@EMPBEDEX.empirix.com>
	<2B407BB2-BBA6-4B13-BF34-DABFB3F8ADEF@kernel.crashing.org>
	<BD261180E6D35F4D9D32F3E44FD3D90106443362@EMPBEDEX.empirix.com>
	<21F08FBD-6702-46A2-9592-329D8CF04073@kernel.crashing.org>
From: "Morrison, Tom" <tmorrison@empirix.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


they have full MPC8548 support...and fwiw, the
standard fedora & debian ppc is incompatible=20
with the e500 core (throws floating point=20
exceptions - due to different FP instruction set)...

I like their update support...

and fyi, freescale already turns on software emulation
in their kernel CDS support package by default. We=20
intend to turn that OFF very soon!

t

-----Original Message-----
From: Kumar Gala [mailto:galak@kernel.crashing.org]
Sent: Tue 1/30/2007 5:50 PM
To: Morrison, Tom
Cc: linuxppc-dev@ozlabs.org
Subject: Re: options for root file system for MPC8548
=20

On Jan 30, 2007, at 4:42 PM, Morrison, Tom wrote:

> You are quick with the questions...:-)

I know :)

I think the timesys solution maybe what you're looking for since they =20
seem to handle security updates to the packages and such.  My concern =20
would be how the handle the e500 platform from a packing point of view.

Do they have just 'ppc' packages, or are they targeted to specific =20
families.

I mean if you're not concerned about FP performance, use debian/=20
fedora/ etc and turn on FP emulation in the kernel.

- k

<snip original describing some deficiencies of some distros>
