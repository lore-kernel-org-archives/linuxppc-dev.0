Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4437DB7E2A
	for <linuxppc-dev@ozlabs.org>; Thu, 13 May 2010 22:05:58 +1000 (EST)
Subject: Re: Large physical address support on e500 platform
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <F3189FB9-C04F-4C04-A6D4-25EF4D9B4BD6@kernel.crashing.org>
Date: Thu, 13 May 2010 07:05:45 -0500
Message-Id: <1ACA5AF0-2838-4031-9BFE-4D4AF8D47E7B@kernel.crashing.org>
References: <bc81dc641001212227w429b0f33hab1e541e69a11bf7@mail.gmail.com>
	<C8218436-3EA1-46F0-8E7E-4699AA06005B@kernel.crashing.org>
	<bc81dc641001250906o18ba8e9cofbb02421ae046f65@mail.gmail.com>
	<F3189FB9-C04F-4C04-A6D4-25EF4D9B4BD6@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Aaron Pace <kodiakuppercut@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 25, 2010, at 11:25 AM, Kumar Gala wrote:

>=20
> On Jan 25, 2010, at 11:06 AM, Aaron Pace wrote:
>=20
>>>=20
>>> Is a simple "hello world" module sufficient to show the issue?  I'll =
look into it this week.
>>>=20
>>> - k
>>=20
>> It wasn't in my situation, unfortunately.  To duplicate this, I had
>> one relatively large kernel module, and then one simple 'hello world'
>> module that did nothing more than call an exported function from the
>> first module as part of its init.
>=20
> Ok, if there is a module or something you can post that reproduces the =
issue that would be extremely helpful.

I think we may now have figured this out.

- k=
