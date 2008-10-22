Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EB16ADDE00
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 23:31:35 +1100 (EST)
Message-Id: <83735324-C37B-4C57-A50F-FFF0D133E4E3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: =?ISO-8859-1?Q?R=E9gis_Odey=E9?= <regis.odeye@kontron.com>
In-Reply-To: <48FEEB88.6050505@kontron.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Extended Addressing Mode
Date: Wed, 22 Oct 2008 07:31:06 -0500
References: <48FEEB88.6050505@kontron.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 22, 2008, at 3:59 AM, R=E9gis Odey=E9 wrote:

> Hello Everyone,
> I'm looking for some information about the Extended Addressing Mode =20=

> (XAEN bit of HID0 register) of PPC32 support in Linux.
> I do not see anything in the main kernel tree but there may be some =20=

> patches available ?
> Any information will be appreciate.
> Regards.

There are patches from Becky Bruce that are going into 2.6.28.  What =20
are you needing >32-bit for?  There are some SW IO MMU changes that =20
are still pending to complete this work.

- k=
