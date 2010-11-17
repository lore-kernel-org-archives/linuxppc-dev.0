Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C198BB7156
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Nov 2010 04:52:58 +1100 (EST)
Subject: Re: [PATCH] kgdb,
	ppc: Corrected the address using of current->thread.evr register
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4CE40F00.7010407@windriver.com>
Date: Wed, 17 Nov 2010 11:52:51 -0600
Message-Id: <4C5CCBFF-4768-4A9A-A805-F47A19D2D539@kernel.crashing.org>
References: <1289912316-4580-1-git-send-email-dongdong.deng@windriver.com>
	<4CE2FF5A.402@windriver.com>
	<983540C0-C0E6-44DB-9264-4A5B1E058043@kernel.crashing.org>
	<4CE40F00.7010407@windriver.com>
To: Jason Wessel <jason.wessel@windriver.com>
Cc: "Deng, Dongdong" <dongdong.deng@windriver.com>,
	Sergei Shtylyov <sshtylyov@mvista.com>,
	kgdb-bugreport@lists.sourceforge.net, miltonm@bga.com, "Hai,
	Shan" <shan.hai@windriver.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 17, 2010, at 11:21 AM, Jason Wessel wrote:

> On 11/17/2010 11:16 AM, Kumar Gala wrote:
>=20
>>> Thanks,
>>> Jason.
>>=20
>> Repost a version with the casts and I'll pick it up.
>>=20
>> - k
>=20
> I have the final version ready for a pull request that I was going to
> make in the next hour or two that is fully regression tested.
>=20
> If you would prefer to these changes in the PPC, let me know, or if
> you want to ack the patch, I'll add that before submitting the pull
> request.
>=20
> Thanks,
> Jason.
>=20
> --

If they'll get pulled in via another path that is fine.  I'm happy to =
ack a proper patch.

- k=
