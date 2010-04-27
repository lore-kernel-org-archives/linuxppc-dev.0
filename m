Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C7B75B7D16
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 14:55:29 +1000 (EST)
Subject: Re: [git pull] Please pull powerpc.git merge branch
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4BD66378.1010603@embedded-sol.com>
Date: Mon, 26 Apr 2010 23:55:16 -0500
Message-Id: <62341C68-07F0-4593-8DCD-F1DEC015ED1F@kernel.crashing.org>
References: <Pine.LNX.4.64.1004192326100.27041@localhost.localdomain>
	<2009D70F-BBE3-4D4D-B1BA-C92041AFE9C9@kernel.crashing.org>
	<4BD66378.1010603@embedded-sol.com>
To: Felix Radensky <felix@embedded-sol.com>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 26, 2010, at 11:09 PM, Felix Radensky wrote:

> Hi Kumar,
>=20
> On 4/27/2010 2:05 AM, Kumar Gala wrote:
>> Ben,
>>=20
>> I've updated this to include this one additional patch for dealing =
with CONFIG_RELOCATE on FSL-BookE ppc32
>>=20
>> http://patchwork.ozlabs.org/patch/51011/
>>=20
>>  =20
>=20
> Can this patch also be included: =
http://patchwork.ozlabs.org/patch/50289/
>=20
> Thanks.
>=20
> Felix.

I didn't consider this a bug fix and thus didn't include it.  It will go =
in for 2.6.35.

- k=
