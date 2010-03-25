Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 78C1FB7C98
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 10:37:09 +1100 (EST)
Subject: Re: Continual reading from the PowerPc time base register is not
	stable
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <43c137a81003250800n660195c5k42c8516068aeda8d@mail.gmail.com>
Date: Thu, 25 Mar 2010 18:37:00 -0500
Message-Id: <019309CF-DEAF-4E9C-8AFE-7D52A6292947@kernel.crashing.org>
References: <43c137a81003241941p84cba56y3e02e40cb22623e2@mail.gmail.com>
	<1269505301.8599.238.camel@pasglop>
	<201003251105.10033.arnd@arndb.de>
	<43c137a81003250800n660195c5k42c8516068aeda8d@mail.gmail.com>
To: Csdncannon <csdncannon@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 25, 2010, at 10:00 AM, Csdncannon wrote:

> I am really sorry that the previously attached code is wrong, this one =
"timebase.c" is the right one, and the "log_timebase" file is the right =
log.
>=20
> We are using FreeScale PowerPc 8378, kernel 2.6.28 and compiled as =
32-bit.
>=20
>=20
> Thanks
> Gino

Is this a custom board or FSL reference board?

- k
