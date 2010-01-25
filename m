Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4FA1D1007D1
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jan 2010 03:46:18 +1100 (EST)
Subject: Re: Large physical address support on e500 platform
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <bc81dc641001212227w429b0f33hab1e541e69a11bf7@mail.gmail.com>
Date: Mon, 25 Jan 2010 10:46:10 -0600
Message-Id: <C8218436-3EA1-46F0-8E7E-4699AA06005B@kernel.crashing.org>
References: <bc81dc641001212227w429b0f33hab1e541e69a11bf7@mail.gmail.com>
To: Aaron Pace <kodiakuppercut@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 22, 2010, at 12:27 AM, Aaron Pace wrote:

>>>=20
>>> Its possible that we've broken module/vmalloc support with
>>> "Large physical addressing".? Its not something I've
>>> tried in a while.? What kernel/git SHA are you using.
>>>=20
>=20
>> I'm just pulling in from the main kernel tree git.
>> My current version is 2.6.33-rc4-00193-gd1e4922-dirty,
>> but it had not changed since 2.6.33-rc2
>>=20
>> I started from 2.6.32, but I don't remember if I had a large PA
>> support enabled there.
>=20
> Just to second this issue, the following commit is what broke this:
>=20
> [76acc2c1a7a9a8c2cae7e9cf8d0a8b374a48aa94]
>=20
> I didn't have time to delve into the whys & hows, but this commit
> caused the same issue on an 8572 platform.
> Reverting this one change allows everything (including 36-bit memory
> access) to work correctly, as before.

Is a simple "hello world" module sufficient to show the issue?  I'll =
look into it this week.

- k=
